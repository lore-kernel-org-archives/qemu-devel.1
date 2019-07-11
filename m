Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A89C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F0920644
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkfsaEU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F0920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbNg-0006cs-VT
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlbNV-00068r-8D
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlbNT-0002Yv-WA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:53:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlbNT-0002Xw-M1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:52:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id x4so6854559wrt.6
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9YbcufNzlju6M7AY3M5bHfqwutINwnDSoWTggoFUdMA=;
 b=qkfsaEU8a1nSGRtmqqm5yJOAB71SYZQ+e2snRabB0JMUlGHOxhmkxCFcnW+eFOOvP3
 85vHygpTs04R+9YNVzLaqCvTYnGgQtraiS2bOda4W8TDtvoxY0MMutuXvHvm8SfnUex8
 vs15J9F1rbxrykIILpDNxtqxW6cspx4Wf3j0WxpryCl48+2IBGWLO54OwEYVEGj2anmd
 yIUlLGiwSfA4oO60jgSHHernAnLDZwuDka5OD6z4UcPFUPAoXrnN6l5ScPeW+LiNuTwR
 U/Ib5wPcEfW6KJ30ptkS96DwSfSAfpfgAvfLLA2tg9La/Yp6YFZZEGZjSlkVNNo1eM/W
 UDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9YbcufNzlju6M7AY3M5bHfqwutINwnDSoWTggoFUdMA=;
 b=rwgkrdczXMd/iQCKKOnbhIG6gTYvAV8uqhmEutPQ+6rcRfV8BO3orMatd3odh1Wu1q
 I9YsSiXlEKfc+q8ysBm1iuBqdG7mVTyh79EoaExkg1I8ye38hSTo5Fu5AjowtRQM+E5T
 8Jt3AdpoNenxPKIg3NH7Yv+iZNxLTTVBh377uxfSfjvxilFZlaqVUZ/BONoHDxkOgJvp
 e1mzFsq/aYYnHx8b/cfT+CzbfnTOxq7qDB7ZkVzGv2dk4F2bSJjSaEReSaVbpNy5KbB4
 i4FkjqZXDxLzFe3CFBQ0Mzzfpb6iUjUDYSM1NAgWq2P7XZTMYteUE4iGlPJ323DCMpO/
 pCDw==
X-Gm-Message-State: APjAAAUAolfXaBeaLy3g/tOXLSOzBJEXqWn8ytYrm1oM2+HdUviyeTVw
 LYMVtleJ65IbkLGibje5vwHRrA==
X-Google-Smtp-Source: APXvYqxv+jmAETsvS27GHWcu2781F69ksOvBSwdkRtX3xTUNXV+/5UYDJ5aW75d+F4Fhym13f/pe8Q==
X-Received: by 2002:adf:f544:: with SMTP id j4mr5987022wrp.150.1562860377450; 
 Thu, 11 Jul 2019 08:52:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c9sm4543168wml.41.2019.07.11.08.52.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 08:52:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 512321FF87;
 Thu, 11 Jul 2019 16:52:56 +0100 (BST)
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-2-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
In-reply-to: <20190709194330.837-2-marcandre.lureau@redhat.com>
Date: Thu, 11 Jul 2019 16:52:56 +0100
Message-ID: <877e8oeffr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 1/5] docker.py: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a --engine option to select either docker, podman or auto.
>
> Among other advantages, podman allows to run rootless & daemonless
> containers, fortunately sharing compatible CLI with docker.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

podman doesn't seem to be widely packaged as of yet so I can't test it
on any of my systems.

> ---
>  tests/docker/docker.py | 43 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 53a8c9c801..1f59a78b10 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -20,6 +20,7 @@ import hashlib
>  import atexit
>  import uuid
>  import argparse
> +import enum
>  import tempfile
>  import re
>  import signal
> @@ -38,6 +39,26 @@ FILTERED_ENV_NAMES =3D ['ftp_proxy', 'http_proxy', 'ht=
tps_proxy']
>
>  DEVNULL =3D open(os.devnull, 'wb')
>
> +class EngineEnum(enum.IntEnum):
> +    AUTO =3D 1
> +    DOCKER =3D 2
> +    PODMAN =3D 3
> +
> +    def __str__(self):
> +        return self.name.lower()
> +
> +    def __repr__(self):
> +        return str(self)
> +
> +    @staticmethod
> +    def argparse(s):
> +        try:
> +            return EngineEnum[s.upper()]
> +        except KeyError:
> +            return s
> +
> +
> +USE_ENGINE =3D EngineEnum.AUTO
>
>  def _text_checksum(text):
>      """Calculate a digest string unique to the text content"""
> @@ -48,9 +69,14 @@ def _file_checksum(filename):
>      return _text_checksum(open(filename, 'rb').read())
>
>
> -def _guess_docker_command():
> -    """ Guess a working docker command or raise exception if not found"""
> -    commands =3D [["docker"], ["sudo", "-n", "docker"]]
> +def _guess_engine_command():
> +    """ Guess a working engine command or raise exception if not found"""
> +    commands =3D []
> +
> +    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
> +        commands +=3D [["podman"]]
> +    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
> +        commands +=3D [["docker"], ["sudo", "-n", "docker"]]
>      for cmd in commands:
>          try:
>              # docker version will return the client details in stdout
> @@ -61,7 +87,7 @@ def _guess_docker_command():
>          except OSError:
>              pass
>      commands_txt =3D "\n".join(["  " + " ".join(x) for x in commands])
> -    raise Exception("Cannot find working docker command. Tried:\n%s" %
> +    raise Exception("Cannot find working engine command. Tried:\n%s" %
>                      commands_txt)
>
>
> @@ -190,7 +216,7 @@ def _dockerfile_preprocess(df):
>  class Docker(object):
>      """ Running Docker commands """
>      def __init__(self):
> -        self._command =3D _guess_docker_command()
> +        self._command =3D _guess_engine_command()
>          self._instances =3D []
>          atexit.register(self._kill_instances)
>          signal.signal(signal.SIGTERM, self._kill_instances)
> @@ -502,6 +528,8 @@ class ProbeCommand(SubCommand):
>                  print("yes")
>              elif docker._command[0] =3D=3D "sudo":
>                  print("sudo")
> +            elif docker._command[0] =3D=3D "podman":
> +                print("podman")
>          except Exception:
>              print("no")
>
> @@ -597,9 +625,13 @@ class CheckCommand(SubCommand):
>
>
>  def main():
> +    global USE_ENGINE
> +
>      parser =3D argparse.ArgumentParser(description=3D"A Docker helper",
>                                       usage=3D"%s <subcommand> ..." %
>                                       os.path.basename(sys.argv[0]))
> +    parser.add_argument("--engine", type=3DEngineEnum.argparse, choices=
=3Dlist(EngineEnum),
> +                        help=3D"specify which container engine to use")
>      subparsers =3D parser.add_subparsers(title=3D"subcommands", help=3DN=
one)
>      for cls in SubCommand.__subclasses__():
>          cmd =3D cls()
> @@ -608,6 +640,7 @@ def main():
>          cmd.args(subp)
>          subp.set_defaults(cmdobj=3Dcmd)
>      args, argv =3D parser.parse_known_args()
> +    USE_ENGINE =3D args.engine
>      return args.cmdobj.run(args, argv)


--
Alex Benn=C3=A9e

