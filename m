Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F67C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728772173B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu/syFB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728772173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43889 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5oRU-0006kI-D8
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5oQ8-0005qg-Uq
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5oQ6-0001jb-OJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:51:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5oQ5-0001ih-2L
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:51:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id 30so1926948wrk.11
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HOEYv2UOrSMnCHnMFvDlVapYWjbCwMktRofSyshCy4c=;
 b=Nu/syFB1A1nc4E2YY4qL3OktuKnIgNKjYNbpFg5T+NpYuuWLqprb+VLrEdiAobI0nd
 30lHamFDBRgquzv21flCYM5rzuTo/Q+ZEWlu8mLRadQ/Qd3quR15htHq2LXjAFwuQ6u9
 hweNvnRq6mHCCNpOwdDphJY+t29yzigotje4wP8KROtRZwqJ18DQLKFq4YsqR3SGpu/E
 WHeEJbm0kJpXmzrBzMheCHs9e6yKHCUQ6PBQDsiQfdXWJrdUBvJCKUoijeeTFtxpN29u
 84O1mJLITvlJQQczYVL5i+KOvW4OLhpTw8wmMsr/UV+UZHzCc5SE3pNSTVs2dSNDhUiz
 uVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HOEYv2UOrSMnCHnMFvDlVapYWjbCwMktRofSyshCy4c=;
 b=n3YLnFo/xRlyq0Yk+lKyygm3vOpTpR/Yn7rywnll0+J7fDasbfCUSWBpP/qez00SFu
 kfakHJ2p2I8PJwxr1vPSgI9ezVFnnfjWEjyuRRcklZFzZjNxjSPDDr1nI8a5viI3LQbI
 byPBYpQ85Pw4xIwbKghCY2lDumOP0nRkiBUtxWbg2hPlgcQxyGyXA8zo/pdGr4eK1o2j
 buFp5e0plxz8IQ+O8U3KbMspusqH8x28GZgGFFra1jJJ9cXfkb6ElVR+Kg9+zVy08tuE
 6t59CawzLbUiB7dZAWTahvEnAQ3hXWAOvrhAQlteeHHL0QrFC5zEYSSm3ycKTpPpQMD3
 h/RQ==
X-Gm-Message-State: APjAAAW175hWBgr6uDv4Q9DnYPLfuw7In24Taas5lmTxwAAea5mYniZs
 O5wa1ZwOCqZHmNpOFmNiKEECvA==
X-Google-Smtp-Source: APXvYqwCV59/z60tUaz1rMFjOH9RdkdLRaJ1+NRl55mGMpqdzvAbiALSgJZzkziTj/LizM/D84+Vdg==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr2013152wrm.42.1567677071136; 
 Thu, 05 Sep 2019 02:51:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm2909427wmc.25.2019.09.05.02.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 02:51:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73FD71FF87;
 Thu,  5 Sep 2019 10:51:09 +0100 (BST)
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-4-alex.bennee@linaro.org>
 <b25bd465-bc39-936f-5c6b-114e2926aba4@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
In-reply-to: <b25bd465-bc39-936f-5c6b-114e2926aba4@redhat.com>
Date: Thu, 05 Sep 2019 10:51:09 +0100
Message-ID: <87ftlb841e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 03/42] tests/docker: fix "cc" command to
 work with podman
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, qemu-devel@nongnu.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 9/4/19 4:29 PM, Alex Benn=C3=A9e wrote:
>> Podman requires a little bit of additional magic to the uid mapping
>> which was already done for the normal RunCommand. We simplify the
>> logic by pushing it directly into the Docker::run method to avoid
>> instantiating an extra Docker() object and ensure the CC command
>> always runs as the current user.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/docker/docker.py     | 30 +++++++++++++++---------------
>>  tests/tcg/Makefile.include |  2 +-
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index e23209f71ee..8f391eb278b 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -318,10 +318,20 @@ class Docker(object):
>>              return False
>>          return checksum =3D=3D _text_checksum(_dockerfile_preprocess(do=
ckerfile))
>>
>> -    def run(self, cmd, keep, quiet):
>> +    def run(self, cmd, keep, quiet, as_user=3DFalse):
>>          label =3D uuid.uuid1().hex
>>          if not keep:
>>              self._instances.append(label)
>> +
>> +        if as_user:
>> +            uid =3D os.getuid()
>> +            cmd =3D [ "-u", str(uid) ] + cmd
>> +            # podman requires a bit more fiddling
>> +            if self._command[0] =3D=3D "podman":
>> +                cmd =3D [ "--uidmap", "%d:0:1" % uid,
>> +                        "--uidmap", "0:1:%d" % uid,
>> +                        "--uidmap", "%d:%d:64536" % (uid + 1, uid + 1)]=
 + cmd
>> +
>
> I was having problems with constructs like these recently. I think we
> either need to use --userns=3Dkeep-id (vastly preferred) or adjust 64536
> there to read as "65536 - uid" because not everyone will have a UID of
> 1000.

From Marc-Andr=C3=A9's original commit:

  With a user 1000, the default mapping is: 1000 (host) -> 0 (container).

  So write access to /var/tmp/ccache ends will end with permission
  denied error.

  With "--uidmap 1000:0:1 --uidmap 0:1:1000", the mapping is:
  1000 (host) -> 0 (container, 1st namespace) -> 1000 (container, 2nd names=
pace).
  (the rest is mumbo jumbo to avoid holes in the range of UIDs)

  A future podman version may have an option such as --userns-keep-uid.
  Thanks to Debarshi Ray <rishi@redhat.com> for the help!

So I assumed this doesn't exist for all versions of podman yet. Given
how new the support is I guess we could just say you need a minimum
version for working podman support.

>
> (My UID is over 20,000 and for whatever reason, this causes podman to
> crash very badly when using this hackaround.)
>
>>          ret =3D self._do_check(["run", "--label",
>>                               "com.qemu.instance.uuid=3D" + label] + cmd,
>>                               quiet=3Dquiet)
>> @@ -364,15 +374,8 @@ class RunCommand(SubCommand):
>>                              help=3D"Run container using the current use=
r's uid")
>>
>>      def run(self, args, argv):
>> -        if args.run_as_current_user:
>> -            uid =3D os.getuid()
>> -            argv =3D [ "-u", str(uid) ] + argv
>> -            docker =3D Docker()
>> -            if docker._command[0] =3D=3D "podman":
>> -                argv =3D [ "--uidmap", "%d:0:1" % uid,
>> -                         "--uidmap", "0:1:%d" % uid,
>> -                         "--uidmap", "%d:%d:64536" % (uid + 1, uid + 1)=
] + argv
>> -        return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>> +        return Docker().run(argv, args.keep, quiet=3Dargs.quiet,
>> +                            as_user=3Dargs.run_as_current_user)
>>
>>
>>  class BuildCommand(SubCommand):
>> @@ -556,8 +559,6 @@ class CcCommand(SubCommand):
>>                              help=3D"The docker image in which to run cc=
")
>>          parser.add_argument("--cc", default=3D"cc",
>>                              help=3D"The compiler executable to call")
>> -        parser.add_argument("--user",
>> -                            help=3D"The user-id to run under")
>>          parser.add_argument("--source-path", "-s", nargs=3D"*", dest=3D=
"paths",
>>                              help=3D"""Extra paths to (ro) mount into co=
ntainer for
>>                              reading sources""")
>> @@ -571,11 +572,10 @@ class CcCommand(SubCommand):
>>          if args.paths:
>>              for p in args.paths:
>>                  cmd +=3D ["-v", "%s:%s:ro,z" % (p, p)]
>> -        if args.user:
>> -            cmd +=3D ["-u", args.user]
>>          cmd +=3D [args.image, args.cc]
>>          cmd +=3D argv
>> -        return Docker().command("run", cmd, args.quiet)
>> +        return Docker().run(cmd, False, quiet=3Dargs.quiet,
>> +                            as_user=3DTrue)
>>
>>
>>  class CheckCommand(SubCommand):
>> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
>> index 73b5626fc5f..210f8428237 100644
>> --- a/tests/tcg/Makefile.include
>> +++ b/tests/tcg/Makefile.include
>> @@ -41,7 +41,7 @@ ifneq ($(DOCKER_IMAGE),)
>>  # We also need the Docker make rules to depend on
>>  include $(SRC_PATH)/tests/docker/Makefile.include
>>
>> -DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>> +DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc \
>>  		--cc $(DOCKER_CROSS_COMPILER) \
>>  		-i qemu:$(DOCKER_IMAGE) \
>>  		-s $(SRC_PATH) -- "
>>


--
Alex Benn=C3=A9e

