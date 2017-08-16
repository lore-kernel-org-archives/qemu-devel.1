Received: from eggs.gnu.org ([2001:4830:134:3::10]:35301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1di5Tl-0007qS-Uz
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1di5Th-0008T8-1M
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1di5Tg-0008Sa-HP
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:03:48 -0400
Date: Thu, 17 Aug 2017 05:03:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170816210337.GB17882@lemon>
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-5-famz@redhat.com>
	<20170816085515.GB3180@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816085515.GB3180@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 4/9] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 08/16 09:55, Stefan Hajnoczi wrote:
> On Wed, Aug 16, 2017 at 03:20:59PM +0800, Fam Zheng wrote:
> > +class BaseVM(object):
> > +    GUEST_USER = "qemu"
> > +    GUEST_PASS = "qemupass"
> > +    ROOT_PASS = "qemupass"
> > +
> > +    # The script to run in the guest that builds QEMU
> > +    BUILD_SCRIPT = ""
> > +    # The guest name, to be overridden by subclasses
> > +    name = "#base"
> > +    def __init__(self, debug=False):
> > +        self._guest = None
> > +        self.ssh_port = 20022
> 
> Only one instance of this test can be run per machine due to the
> hardcoded SSH port number on the host.
> 
> It is possible to use:
> 
>   -netdev user,id=vnet,hostfwd=:0.0.0.0:0-:22
> 
> and then query the port number:
> 
>   (qemu) info usernet
>   VLAN -1 (vnet):
>   Protocol[State]    FD  Source Address  Port   Dest. Address  Port RecvQ SendQ
>   TCP[HOST_FORWARD]  15               * 36089       10.0.2.15    22     0     0
> 
> The host port is 36089 in this example.
> 
> I'm not aware of a QMP equivalent for "info usernet".  It may be
> necessary to implement a query-usernet command if you don't want to use
> HMP.

Sounds good. Will try. Using HMP is good enough to start with, we can add
query-usernet on top.

> 
> > +        self._tmpdir = tempfile.mkdtemp(prefix="qemu-vm-")
> > +        atexit.register(shutil.rmtree, self._tmpdir)
> > +
> > +        self._ssh_key_file = os.path.join(self._tmpdir, "id_rsa")
> > +        open(self._ssh_key_file, "w").write(SSH_KEY)
> > +        subprocess.check_call(["chmod", "600", self._ssh_key_file])
> > +
> > +        self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
> > +        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
> > +
> > +        self.debug = debug
> > +        self._stderr = sys.stderr
> > +        self._devnull = open("/dev/null", "w")
> > +        if self.debug:
> > +            self._stdout = sys.stdout
> > +        else:
> > +            self._stdout = self._devnull
> > +        self._args = [ \
> > +            "-nodefaults", "-enable-kvm", "-m", "2G",
> > +            "-smp", os.environ.get("J", "4"), "-cpu", "host",
> 
> Can this be a command-line option in main() and a constructor argument
> instead of an environment variable?  That would be cleaner because the
> use of "J" might be surprising to someone who happens to have it set in
> their environment.

Yes, "J" should be handled in the Makefile.

> 
> > +            "-netdev", "user,id=vnet,hostfwd=:0.0.0.0:%d-:22" % self.ssh_port,
> > +            "-device", "virtio-net-pci,netdev=vnet",
> > +            "-vnc", ":0,to=20",
> > +            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
> > +
> > +        self._data_args = []
> > +
> > +    def _download_with_cache(self, url):
> > +        cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
> > +        subprocess.check_call(["mkdir", "-p", cache_dir])
> 
> os.makedirs()

OK.

> 
> > +        fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
> > +        if os.path.exists(fname):
> > +            return fname
> > +        logging.debug("Downloading %s to %s...", url, fname)
> > +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"],
> > +                              stdout=self._stdout, stderr=self._stderr)
> 
> It might be important to support image file updates without manually
> deleting ~/.cache.  You can probably make wget send an HTTP
> If-Modified-Since header or something similar.  There are 3 cases:
> 
> 1. Existing file is up-to-date.  No download after HEAD request.
> 2. Existing file is outdated, download the newest version.
> 3. Failure or timeout, use the old version for now.

Since the URLs are not https, maybe add sha256sum of images in the subclasses so
it is MITM-safe? It is also much simpler code, I think.

> 
> > +        subprocess.check_call(["mv", fname + ".download", fname],
> > +                              stdout=self._stdout, stderr=self._stderr)
> 
> os.rename()

OK.

Fam
