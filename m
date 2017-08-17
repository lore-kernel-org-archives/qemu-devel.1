Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diJoC-0005rH-T9
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1diJo9-0005Zl-IT
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1diJo9-0005Yt-9E
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:21:53 -0400
Date: Thu, 17 Aug 2017 13:21:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170817122148.GE5539@stefanha-x1.localdomain>
References: <20170817024746.5961-1-famz@redhat.com>
	<20170817024746.5961-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
In-Reply-To: <20170817024746.5961-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 04/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 17, 2017 at 10:47:40AM +0800, Fam Zheng wrote:
> +        self._args = [ \
> +            "-nodefaults", "-enable-kvm", "-m", "2G",
> +            "-smp", os.environ.get("J", "4"), "-cpu", "host",

I suggested making -j a command-line argument and constructor argument
instead of using a environment variable.  Your email reply seemed to
agree but this patch is still using an environment variable.  Did you
forget?

> +    def boot(self, img, extra_args=[]):
> +        args = self._args + [
> +            "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
> +            "-device", "virtio-blk,drive=drive0,bootindex=0"]
> +        args += self._data_args + extra_args
> +        logging.debug("QEMU args: %s", " ".join(args))
> +        guest = QEMUMachine(binary=os.environ.get("QEMU", "qemu-system-x86_64"),
> +                            args=args)
> +        guest._vga = "std"

_vga is a protected field.  We don't inherit from QEMUMachine so it
shouldn't be accessed directly.  One option is to add a vga argument to
the QEMUMachine() constructor.

> +        guest.launch()
> +        atexit.register(self.shutdown)
> +        self._guest = guest
> +        usernet_info = guest.qmp("human-monitor-command",
> +                                 command_line="info usernet")
> +        self.ssh_port = None
> +        for l in usernet_info["return"].splitlines():
> +            fields = l.split()
> +            if "TCP[HOST_FORWARD]" in fields and "22" in fields:
> +                self.ssh_port = l.split()[3]
> +        if not self.ssh_port:
> +            raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
> +                            usernet_info)
> +
> +    def wait_ssh(self, seconds=120):
> +        guest_remote = self.GUEST_USER + "@127.0.0.1"

Please remove this unused variable.

> +def parse_args(vm_name):
> +    parser = argparse.ArgumentParser()

Python 2.6 only has optparse, not argparse.  Perhaps we can raise the
minimum Python version requirement to 2.7 starting from QEMU 2.11.  For
the time being it would be necessary to use optparse instead.

> +    parser.add_argument("--debug", "-D", action="store_true",
> +                        help="enable debug output")
> +    parser.add_argument("--image", "-i", default="%s.img" % vm_name,
> +                        help="image file name")
> +    parser.add_argument("--force", "-f", action="store_true",
> +                        help="force build image even if image exists")
> +    parser.add_argument("--build-image", "-b", action="store_true",
> +                        help="build image")
> +    parser.add_argument("--build-qemu",
> +                        help="build QEMU from source in guest")
> +    parser.add_argument("--interactive", "-I", action="store_true",
> +                        help="Interactively run command")
> +    return parser.parse_known_args()

Documentation would be really helpful.  I'm not sure what workflow you
have in mind for this command-line tool.  There are two scenarios that
would be good to document:
1. How to invoke and use existing images for tests.
2. How to create new images (e.g. add a guest operating system).

> +
> +def main(vmcls):
> +    args, argv = parse_args(vmcls.name)
> +    if not argv and not args.build_qemu:
> +        print "Nothing to do?"
> +        return 1
> +    if args.debug:
> +        logging.getLogger().setLevel(logging.DEBUG)
> +    vm = vmcls(debug=args.debug)
> +    if args.build_image:
> +        if os.path.exists(args.image) and not args.force:
> +            sys.stderr.writelines(["Image file exists: %s\n" % img,
> +                                  "Use --force option to overwrite\n"])
> +            return 1
> +        return vm.build_image(args.image)
> +    if args.build_qemu:
> +        vm.add_source_dir(args.build_qemu)
> +        cmd = [vm.BUILD_SCRIPT.format(
> +               configure_opts = " ".join(argv),
> +               jobs=os.environ.get("J", "4"))]
> +    else:
> +        cmd = argv
> +    vm.boot(args.image + ",snapshot=on")
> +    vm.wait_ssh()

This method returns 2 on timeout.  Exit here?

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlYpcAAoJEJykq7OBq3PIcf0H/j5xyaNvkeJmfYIZp9P6hPEk
ujnWjqxePZNuq4rNo1k0WrnlUSFje2TSCXhy8hDuKp3xGjgrVjlGVwbISGHemt9s
mGdkO3iQ964EKAC9x8ArJ7mlDmwn4ruZqf8paVPFOeeS3gAuLCqG7sTwG3SJRFcv
eao5+YHRqRODTjrTwfG+IlBjoVyAnDV/U1dVYQ+7XoyYDjaZdcHlBFEqnYFJkpGS
H3mfsCHHT+prMIIiBw1FQlBbRt0r1prsgWQV9nLONFRkODXjMpGJIWgtzobcJo4W
9rSMm4zYxi0WJ2FToZL/GKAk3SeVcuhMajbCthg0gQc0HcJ9Gy1JWyXmfgHkAeY=
=3tO+
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
