Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C89C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6B620823
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ik39fda+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6B620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc9iE-0006rI-1a
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 11:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc9gu-0006RH-Ed
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:34:32 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc9gt-0006Ns-7S
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:34:31 -0400
Received: by mail-ed1-x543.google.com with SMTP id d24so9523587eds.11
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lhUws9CcVwQImGqjee9B8+WGP9k3GELVFYsGjPi0Jr4=;
 b=ik39fda+y5S8MBNh7BwKYTFZ7beN+N4toAveBjZuACnWH6qjZMUyRM2NMdN0QdEdUN
 tPK87k5kAsRcqY8OVRtNTOLl0ZeGeBl3HRy3M7srgIxI5tT0KAJtZRUt7VXCNS2+yS7V
 /8LypoXskET8t2H17qeW5gQowpFA9t2sTo90pmgZGUycmK3e+1rUFIXXttUBaSAnKQBP
 Q7l3dvtiAQt25z2aLLL8WO40gVPjKrZlVTq+1rhp4zDe2O65giFRylBl6zHYWXZlUqBD
 6YxYtp9r28xTjwOFzhdgFs7HMmSSPjUS3e8JQSahk9SVo3/mcqL0BRzpzzu1Pnr4VlX0
 45Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lhUws9CcVwQImGqjee9B8+WGP9k3GELVFYsGjPi0Jr4=;
 b=lfnFoSFiiQtIMH0Omwn7g5wsnqwl6KVc4uFsmwGMHwX6DZlwQ80Ccy9sYqRW8Dooqm
 CUFxXDzpNfpx/B/rGeGfQC/++Kz8q0PEBb7c7D+NBy1h5BDDKVebwKJQz1vz6NkSz6GB
 u49Xcl7Qzt27+QG/mcwI104LCjW2kOGcI9jS/eLuKqqH/Mj1iKqN3r7drMNGI/DG+xCk
 T+RPFsnadHv+MbzorNh9BMyiCBD/DrxDBxa+81Yoi2mIMXmneMpWbQ23luRt1tYRWWAr
 gKHeecPDLrBu/vZGrSFSd7q5QasBTzQfM/CHUS3s5LU7kt4wULZWhVU3nWdhgdKnDOmb
 b+8g==
X-Gm-Message-State: AOAM5328LcVMBRHkn4xkNA6bQaqySue/snXny1SjXEM+QIhZw96qBq93
 8sFIipQMpz8T9Znu/95tjgUlWA==
X-Google-Smtp-Source: ABdhPJwolmoRymgrYD2rLxB19yUsweNKkNCkqgkomu52HiEmiWUX6aiQTk/8dJINMhjFgkMF7qD7/Q==
X-Received: by 2002:a50:99de:: with SMTP id n30mr3343447edb.248.1590161669446; 
 Fri, 22 May 2020 08:34:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id gf25sm8193888ejb.54.2020.05.22.08.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 08:34:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 836761FF7E;
 Fri, 22 May 2020 16:34:27 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-10-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 09/12] tests/vm: Added a new script for ubuntu.aarch64.
In-reply-to: <20200519132259.405-10-robert.foley@linaro.org>
Date: Fri, 22 May 2020 16:34:27 +0100
Message-ID: <878shkdlvg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> ubuntu.aarch64 provides a script to create an Ubuntu 18.04 VM.
> Another new file is also added aarch64vm.py, which is a module with
> common methods used by aarch64 VMs, such as how to create the
> flash images.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  configure                 |  20 +++++++
>  tests/vm/Makefile.include |  11 ++++
>  tests/vm/aarch64vm.py     | 106 ++++++++++++++++++++++++++++++++++
>  tests/vm/basevm.py        |  12 ++++
>  tests/vm/ubuntu.aarch64   | 117 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 266 insertions(+)
>  create mode 100644 tests/vm/aarch64vm.py
>  create mode 100755 tests/vm/ubuntu.aarch64
>
> diff --git a/configure b/configure
> index 89d11aa5d4..d38db335dd 100755
> --- a/configure
> +++ b/configure
> @@ -411,6 +411,7 @@ prefix=3D"/usr/local"
>  mandir=3D"\${prefix}/share/man"
>  datadir=3D"\${prefix}/share"
>  firmwarepath=3D"\${prefix}/share/qemu-firmware"
> +efi_aarch64_arg=3D
>  qemu_docdir=3D"\${prefix}/share/doc/qemu"
>  bindir=3D"\${prefix}/bin"
>  libdir=3D"\${prefix}/lib"
> @@ -1099,6 +1100,8 @@ for opt do
>    ;;
>    --firmwarepath=3D*) firmwarepath=3D"$optarg"
>    ;;
> +  --efi-aarch64=3D*) efi_aarch64_arg=3D"$optarg"
> +  ;;
>    --host=3D*|--build=3D*|\
>    --disable-dependency-tracking|\
>    --sbindir=3D*|--sharedstatedir=3D*|\
> @@ -1753,6 +1756,7 @@ Advanced options (experts only):
>    --sysconfdir=3DPATH        install config in PATH$confsuffix
>    --localstatedir=3DPATH     install local state in PATH (set at runtime=
 on win32)
>    --firmwarepath=3DPATH      search PATH for firmware files
> +  --efi-aarch64=3DPATH       PATH of efi file to use for aarch64 VMs.
>    --with-confsuffix=3DSUFFIX suffix for QEMU data inside datadir/libdir/=
sysconfdir [$confsuffix]
>    --with-pkgversion=3DVERS   use specified string as sub-version of the =
package
>    --enable-debug           enable common debug build options
> @@ -3548,6 +3552,20 @@ EOF
>    fi
>  fi
>=20=20
> +############################################
> +# efi-aarch64 probe
> +# Check for efi files needed by aarch64 VMs.
> +# By default we will use the efi included with QEMU.
> +# Allow user to override the path for efi also.
> +qemu_efi_aarch64=3D$PWD/pc-bios/edk2-aarch64-code.fd

as you only define this once there is no harm in just having a long line
bellow rather than running the potential confusion when looking at the
variables.

> +for fd in $efi_aarch64_arg $qemu_efi_aarch64
> +do
> +    if test -f $fd; then
> +        efi_aarch64=3D$fd
> +        break
> +    fi
> +done

This only detects the pc-bios bundled version of edk on a directory
which has already been built. Maybe we need to do a straight forward:

  if not test -f $efi_aarch64; then
      if test -f $SRC/pc-bios/edk2-aarch64-code.fd.bz2; then
          # valid after build
          efi_aarch64=3D$PWD/pc-bios/edk2-aarch64-code.fd
      else
          efi_aarch64=3D""
      fi
  fi

what do you think?

<snip>
> +
> +    def build_image(self, img):
> +        os_img =3D self._download_with_cache(self.image_link)
> +        img_tmp =3D img + ".tmp"
> +        subprocess.check_call(["cp", "-f", os_img, img_tmp])
> +        subprocess.check_call(["qemu-img", "resize", img_tmp, "+50G"])
> +        ci_img =3D self.gen_cloud_init_iso()
> +
> +        self.boot(img_tmp, extra_args =3D ["-cdrom", ci_img])
> +        if self.debug:
> +            self.wait_boot()
> +        # First command we issue is fix for slow ssh login.
> +        self.wait_ssh(wait_root=3DTrue,
> +                      cmd=3D"chmod -x /etc/update-motd.d/*")
> +        # Wait for cloud init to finish
> +        self.wait_ssh(wait_root=3DTrue,
> +                      cmd=3D"ls /var/lib/cloud/instance/boot-finished")
> +        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
> +        # Disable auto upgrades.
> +        # We want to keep the VM system state stable.
> +        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20aut=
o-upgrades')
> +        # If the user chooses *not* to do the second phase,
> +        # then we will jump right to the graceful shutdown
> +        if self._config['install_cmds'] !=3D "":
> +            self.ssh_root("sync")
> +            # Shutdown and then boot it again.
> +            # Allows us to know for sure it is booting (not shutting dow=
n)
> +            # before we call wait_ssh().
> +            self.graceful_shutdown()
> +            self.boot(img_tmp)
> +            if self.debug:
> +                self.wait_boot()
> +            self.wait_ssh(wait_root=3DTrue)
> +            self.wait_ssh(wait_root=3DTrue, cmd=3D"locale")

Why do we need to shutdown before proceeding with the install commands?
I see ubuntu.i386 does it as well although with a slightly hackier
approach.

> +            # The previous update sometimes doesn't survive a reboot, so=
 do it again
> +            self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sour=
ces.list")
> +
> +            # Issue the install commands.
> +            # This can be overriden by the user in the config .yml.
> +            install_cmds =3D self._config['install_cmds'].split(',')
> +            for cmd in install_cmds:
> +                self.ssh_root(cmd)
> +        self.graceful_shutdown()
> +        self.wait()
> +        os.rename(img_tmp, img)
> +        return 0

How come we are diverging from the ubuntu.i386 install here? You've
moved all the complications for aarch64 into a it's own handling so
these steps are almost but not quite the same. Couldn't the ubuntu
build_img code be common and then just have a slightly different set of
install commands?

> +
> +if __name__ =3D=3D "__main__":
> +    defaults =3D aarch64vm.get_config_defaults(UbuntuAarch64VM, DEFAULT_=
CONFIG)
> +    sys.exit(basevm.main(UbuntuAarch64VM, defaults))


--=20
Alex Benn=C3=A9e

