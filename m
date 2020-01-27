Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF460206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnjsTuCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF460206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3WL-0006Hz-1F
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iw3Tg-0002jL-LK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iw3Tf-0001u3-1B
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:26:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iw3Te-0001tQ-Pn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:26:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so11038432wrn.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r01hl/4I/Wxv/dRyuv/JtENZX98dfYvUU5wVy5nzpw8=;
 b=LnjsTuCXjWDKpFe4laioZuE8/7UhEXwrx8QWpwGlEq9Wo2rN883teW82ThepwTs4K6
 Fc3QWVw16hrQm7xvLCBZCiyEh4tQykviZ39HoJK/7jev2MWvHerBgCdjlY0WSA4S6qq8
 JNtQSeAN6Z/v3SjOik1GBVMlrQr78JTB+h7pa45RACAZ98X7yfoTQZ9ebaVwfVFrAPN0
 ZP3LbYHiMWHCjYaHhZp5GvPiQkOYY0FTGoxryOjJ7OyEbOB6n0i/CohX2RebvtQvMs0l
 5XOhrpmAW8z0LKIBeKW1BubfzH0za3nuoTxsQpkp/hGmiDl7rEmXCYMjQZnfTTsgqcl7
 eJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r01hl/4I/Wxv/dRyuv/JtENZX98dfYvUU5wVy5nzpw8=;
 b=rRnp4QZfktRDTgSlU7+V9Q5BRMfCMnyiMRSFd+NRmhCNhYEjF+0H6p5srtzutYxNfU
 RCFGwY0xD7yuc/vGh/DjiFBC3+cIgOSEV9HJ2M2r3ocdoybjqrCVa0P4kxHH18NDzgI6
 /wKV/Di69ryfyJf+kPQgdFwG1Se6m5kespA3xuQ4HE+HCSKZcWgpshJ0yz+6XgjO9FY5
 P595TQsESG38sqjSe+D/+xwyrQCtqHZa+gLx/ae9UYVvtkA093KuzQb3lKppbTjgvVBe
 gVXuN9NOIcGIfmIQqPsKGDS1RLeIM+fxr3AlAAsZNb6cFXc4BC9o9Dfr2qRdTRDAAqrD
 loZw==
X-Gm-Message-State: APjAAAUKDTTmu/z9abHMa8qQf3BhSROdkdlbM5RYsxbo3cBR5imrMzIn
 2ucD8iItUAgmK7KQ7oqYCTGxFw==
X-Google-Smtp-Source: APXvYqzPqUlefRW4iepw1QidaLmZCXDlRIHVNtVtqESufzXYUzAV8K4za8N71zUW6hpw5s9BUArwPA==
X-Received: by 2002:adf:b193:: with SMTP id q19mr21248956wra.78.1580128009147; 
 Mon, 27 Jan 2020 04:26:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a5sm18337246wmb.37.2020.01.27.04.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 04:26:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0AA171FF87;
 Mon, 27 Jan 2020 12:26:47 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-5-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 4/8] tests/vm: Add configuration to basevm.py
In-reply-to: <20200124165335.422-5-robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 12:26:47 +0000
Message-ID: <87sgk1f5ko.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added use of a configuration to tests/vm/basevm.py.
> The configuration provides parameters used to configure a VM.
> This allows for providing alternate configurations to the VM being
> created/launched. cpu, machine, memory, and NUMA configuration are all
> examples of configuration which we might want to vary on the VM being cre=
ated
> or launched.
> This will for example allow for creating an aarch64 vm.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  tests/vm/basevm.py | 108 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 82 insertions(+), 26 deletions(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 3b4403ddcb..ec92c8f105 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -32,15 +32,40 @@ import shutil
>  import multiprocessing
>  import traceback
>=20=20
> -SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
> -               "..", "keys", "id_rsa")).read()
> -SSH_PUB_KEY =3D open(os.path.join(os.path.dirname(__file__),
> -                   "..", "keys", "id_rsa.pub")).read()
> -
> +SSH_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
> +               "..", "keys", "id_rsa")
> +SSH_PUB_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
> +                   "..", "keys", "id_rsa.pub")
> +SSH_KEY =3D open(SSH_KEY_FILE).read()
> +SSH_PUB_KEY =3D open(SSH_PUB_KEY_FILE).read()

Why are we tracking more information about the keyfile than we used to
now? Is this because it's harder to embed keys over paths in the config?=20

> +
> +# This is the standard configuration.
> +# Any or all of these can be overridden by
> +# passing in a config argument to the VM constructor.
> +DEFAULT_CONFIG =3D {
> +    'cpu'             : "max",
> +    'machine'         : 'pc',
> +    'guest_user'      : "qemu",
> +    'guest_pass'      : "qemupass",
> +    'root_pass'       : "qemupass",
> +    'ssh_key_file'    : SSH_KEY_FILE,
> +    'ssh_pub_key_file': SSH_PUB_KEY_FILE,
> +    'memory'          : "4G",
> +    'extra_args'      : [],
> +    'dns'             : "",
> +    'ssh_port'        : 0,
> +    'install_cmds'    : "",
> +    'boot_dev_type'   : "block",
> +    'ssh_timeout'     : 1,
> +}
> +BOOT_DEVICE =3D {
> +    'block' :  "-drive file=3D{},if=3Dnone,id=3Ddrive0,cache=3Dwriteback=
 "\
> +               "-device virtio-blk,drive=3Ddrive0,bootindex=3D0",
> +    'scsi'  :  "-device virtio-scsi-device,id=3Dscsi "\
> +               "-drive file=3D{},format=3Draw,if=3Dnone,id=3Dhd0 "\
> +               "-device scsi-hd,drive=3Dhd0,bootindex=3D0",
> +}
>  class BaseVM(object):
> -    GUEST_USER =3D "qemu"
> -    GUEST_PASS =3D "qemupass"
> -    ROOT_PASS =3D "qemupass"

Don't we need these?

>=20=20
>      envvars =3D [
>          "https_proxy",
> @@ -59,19 +84,26 @@ class BaseVM(object):
>      poweroff =3D "poweroff"
>      # enable IPv6 networking
>      ipv6 =3D True
> -    def __init__(self, debug=3DFalse, vcpus=3DNone):
> +    def __init__(self, debug=3DFalse, vcpus=3DNone, config=3DNone):
>          self._guest =3D None
> +        # Allow input config to override defaults.
> +        self._config =3D DEFAULT_CONFIG.copy()
> +        if config !=3D None:
> +            self._config.update(config)
>          self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
>                                                           suffix=3D".tmp",
>                                                           dir=3D"."))
>          atexit.register(shutil.rmtree, self._tmpdir)
> -
> +        self._config['ssh_key'] =3D \
> +            open(self._config['ssh_key_file']).read().rstrip()
> +        self._config['ssh_pub_key'] =3D \
> +            open(self._config['ssh_pub_key_file']).read().rstrip()
>          self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
> -        open(self._ssh_key_file, "w").write(SSH_KEY)
> +        open(self._ssh_key_file, "w").write(self._config['ssh_key'])
>          subprocess.check_call(["chmod", "600", self._ssh_key_file])
>=20=20
>          self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.pu=
b")
> -        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
> +        open(self._ssh_pub_key_file,
>          "w").write(self._config['ssh_pub_key'])

Read as a block I find this confusing:

        self._config['ssh_key'] =3D \
            open(self._config['ssh_key_file']).read().rstrip()
        self._config['ssh_pub_key'] =3D \
            open(self._config['ssh_pub_key_file']).read().rstrip()
        self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
        open(self._ssh_key_file, "w").write(self._config['ssh_key'])
        subprocess.check_call(["chmod", "600", self._ssh_key_file])

        self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.pub")
        open(self._ssh_pub_key_file, "w").write(self._config['ssh_pub_key'])

We read config['ssh_key_file'] but write out _ssh_pub_key_file which
doesn't seem related.=20

<snip>

--=20
Alex Benn=C3=A9e

