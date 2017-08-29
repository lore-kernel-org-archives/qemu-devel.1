Received: from eggs.gnu.org ([2001:4830:134:3::10]:37651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmkP3-000305-4U
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmkOz-00067N-3x
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:34:17 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:33107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmkOy-00067H-Vh
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 13:34:13 -0400
Received: by mail-qk0-x22b.google.com with SMTP id l65so18171197qkc.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 10:34:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c751fc1d-602a-25ed-edb9-84ccdaeb2ecb@amsat.org>
Date: Tue, 29 Aug 2017 14:34:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170828174707.20786-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 08/28/2017 02:47 PM, Fam Zheng wrote:
[...]
> +    def __init__(self, debug=False, vcpus=None):
> +        self._guest = None
> +        self._tmpdir = tempfile.mkdtemp(prefix="qemu-vm-")
> +        atexit.register(shutil.rmtree, self._tmpdir)
> +
> +        self._ssh_key_file = os.path.join(self._tmpdir, "id_rsa")
> +        open(self._ssh_key_file, "w").write(SSH_KEY)
> +        subprocess.check_call(["chmod", "600", self._ssh_key_file])
> +
> +        self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
> +        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
> +
> +        self.debug = debug
> +        self._stderr = sys.stderr
> +        self._devnull = open("/dev/null", "w")
> +        if self.debug:
> +            self._stdout = sys.stdout
> +        else:
> +            self._stdout = self._devnull
> +        self._args = [ \
> +            "-nodefaults", "-m", "2G",
> +            "-cpu", "host",
> +            "-netdev", "user,id=vnet,hostfwd=:0.0.0.0:0-:22",
> +            "-device", "virtio-net-pci,netdev=vnet",
> +            "-vnc", ":0,to=20",
> +            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
> +        if vcpus:
> +            self._args += ["-smp", str(vcpus)]

What about enabling mttcg which isn't default?

             self._args += ["--accel", "tcg,thread=multi"]

> +        if os.access("/dev/kvm", os.R_OK | os.W_OK):
> +            self._args += ["-enable-kvm"]
> +        else:
> +            logging.info("KVM not available, not using -enable-kvm")
> +        self._data_args = []
[...]
