Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BD920720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwNDT5aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BD920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxaU-00028f-Gk
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtxZs-0001UO-7H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:16:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtxZq-0004Mi-83
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:16:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so6881439wrw.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/X2nUt0u+nO35jjzlgdfajdxH5O84jnoFpCRg/XBUAU=;
 b=YwNDT5aK+7QSq5uVTFnL8oll8GO78meCT9SL0fIB3/lU5RYEhrDex3juDiTPtqAoMK
 Q+l5PGq9wlIVSg611fNHtAtaQ4B9NzaY6Na7eDPgPYq6y57/6T51fnIrs2eMD1CB4kd6
 zwV/dNEm0vlsHGWtigfFQ4nMVmuay5fhC34ANUc0pRMXok1MSxyLO9kcMAGnmLtu8aJJ
 Z61v7VLR5GooY44cMyxmqyGYzy3jwYwXt9QszTUfTrrHwdxLq+3dqm3K8mVt5IGAWkUw
 gO2zLzXfp5joBWP3UkPJBiEpDEcam8J7W4hl32WizEp7cTnIA+o+bUHO254idJUKoohv
 6+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/X2nUt0u+nO35jjzlgdfajdxH5O84jnoFpCRg/XBUAU=;
 b=m81w5Ib8AWPk75nfuC5ctura6/LLrESaxvqLe1yjxJDI2Z7b5U7Fd9p6wRE12y5LKf
 r84DcX1BmHqbA+IUaECB+CEH4Zb7rw98C0GpCw8qI3h1dthRX2uN8LgpzKeNm1bAG6n0
 TH9uOfBM+SURjRMZfon1N2b8C47KXYTT5JOnQiKlJHoyjAVdP2sH59DOl8pN4S6vgNqg
 1JU5sLNG+Mj+aw8Xr0hjXxe9B81X0kpjaVtTNPVnr9ccz0QzIr42Q1OGwSmACumRyXqU
 nbPbp2y8vdnBWaADVfCjIUUCiwJodG9fI7vVjwF8qj62gw4uEcDt1nGUs4pQZf2+ds6W
 UWGw==
X-Gm-Message-State: AOAM530g1HoUgV+7eOHNHiiODGs+Wc9YGTQcSErsNK0nJs+liAh5IhDG
 /zyvU+UsfDhzYxf88i4ElcUg+w==
X-Google-Smtp-Source: ABdhPJzga2PUmtETlad4aQiYldxGR5B4W8VIMgFkNR87NpQZAl55QG3NJOpIVSgKrAzlyapO0f4j+w==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr67736969wrl.129.1594405008520; 
 Fri, 10 Jul 2020 11:16:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d28sm10670664wrc.50.2020.07.10.11.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 11:16:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 505E61FF7E;
 Fri, 10 Jul 2020 19:16:46 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-12-alex.bennee@linaro.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v4 11/40] tests/vm: change scripts to use self._config
In-reply-to: <20200701135652.1366-12-alex.bennee@linaro.org>
Date: Fri, 10 Jul 2020 19:16:46 +0100
Message-ID: <87r1tjjkvl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Peter Puhov <peter.puhov@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Robert Foley <robert.foley@linaro.org>
>
> This change converts existing scripts to using for example self.ROOT_PASS,
> to self._config['root_pass'].
> We made similar changes for GUEST_USER, and GUEST_PASS.
> This allows us also to remove the change in basevm.py,
> which adds __getattr__ for backwards compatibility.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200601211421.1277-8-robert.foley@linaro.org>
> ---
>  tests/vm/basevm.py | 11 ++---------
>  tests/vm/fedora    | 17 +++++++++--------
>  tests/vm/freebsd   | 16 ++++++++--------
>  tests/vm/netbsd    | 19 ++++++++++---------
>  tests/vm/openbsd   | 17 +++++++++--------
>  5 files changed, 38 insertions(+), 42 deletions(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 5fd66f6b26a..f716798b405 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -183,13 +183,6 @@ class BaseVM(object):
>          self.console_init(timeout=3Dtimeout)
>          self.console_wait(wait_string)
>=20=20
> -    def __getattr__(self, name):
> -        # Support direct access to config by key.
> -        # for example, access self._config['cpu'] by self.cpu
> -        if name.lower() in self._config.keys():
> -            return self._config[name.lower()]
> -        return object.__getattribute__(self, name)
> -
>      def _download_with_cache(self, url, sha256sum=3DNone, sha512sum=3DNo=
ne):
>          def check_sha256sum(fname):
>              if not sha256sum:
> @@ -239,13 +232,13 @@ class BaseVM(object):
>          return r
>=20=20
>      def ssh(self, *cmd):
> -        return self._ssh_do(self.GUEST_USER, cmd, False)
> +        return self._ssh_do(self._config["guest_user"], cmd, False)
>=20=20
>      def ssh_root(self, *cmd):
>          return self._ssh_do("root", cmd, False)
>=20=20
>      def ssh_check(self, *cmd):
> -        self._ssh_do(self.GUEST_USER, cmd, True)
> +        self._ssh_do(self._config["guest_user"], cmd, True)
>=20=20
>      def ssh_root_check(self, *cmd):
>          self._ssh_do("root", cmd, True)
> diff --git a/tests/vm/fedora b/tests/vm/fedora
> index a9195670f4b..b2b478fdbca 100755
> --- a/tests/vm/fedora
> +++ b/tests/vm/fedora
> @@ -108,20 +108,20 @@ class FedoraVM(basevm.BaseVM):
>=20=20
>          self.console_wait_send("7) [!] Root password",     "7\n")
>          self.console_wait("Password:")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>          self.console_wait("Password (confirm):")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>=20=20
>          self.console_wait_send("8) [ ] User creation",     "8\n")
>          self.console_wait_send("1) [ ] Create user",       "1\n")
>          self.console_wait_send("3) User name",             "3\n")
> -        self.console_wait_send("ENTER:", "%s\n" % self.GUEST_USER)
> +        self.console_wait_send("ENTER:", "%s\n" % self._config["guest_us=
er"])
>          self.console_wait_send("4) [ ] Use password",      "4\n")
>          self.console_wait_send("5) Password",              "5\n")
>          self.console_wait("Password:")
> -        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_send("%s\n" % self._config["guest_pass"])
>          self.console_wait("Password (confirm):")
> -        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_send("%s\n" % self._config["guest_pass"])
>          self.console_wait_send("7) Groups",                "c\n")
>=20=20
>          while True:
> @@ -139,7 +139,7 @@ class FedoraVM(basevm.BaseVM):
>              if good:
>                  break
>              time.sleep(10)
> -            self.console_send("r\n" % self.GUEST_PASS)
> +            self.console_send("r\n" % self._config["guest_pass"])
>=20=20
>          self.console_wait_send("'b' to begin install",     "b\n")
>=20=20
> @@ -150,12 +150,13 @@ class FedoraVM(basevm.BaseVM):
>=20=20
>          # setup qemu user
>          prompt =3D " ~]$"
> -        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
> +        self.console_ssh_init(prompt, self._config["guest_user"],
> +                                      self._config["guest_pass"])
>          self.console_wait_send(prompt, "exit\n")
>=20=20
>          # setup root user
>          prompt =3D " ~]#"
> -        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_ssh_init(prompt, "root", self._config["root_pass"])
>          self.console_sshd_config(prompt)
>=20=20
>          # setup virtio-blk #1 (tarfile)
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index f87db2b126e..29252fa4a64 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -113,9 +113,9 @@ class FreeBSDVM(basevm.BaseVM):
>=20=20
>          # post-install configuration
>          self.console_wait("New Password:")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>          self.console_wait("Retype New Password:")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>=20=20
>          self.console_wait_send("Network Configuration", "\n")
>          self.console_wait_send("IPv4",                  "y")
> @@ -134,9 +134,9 @@ class FreeBSDVM(basevm.BaseVM):
>          # qemu user
>          self.console_wait_send("Add User Accounts", "y")
>          self.console_wait("Username")
> -        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_send("%s\n" % self._config["guest_user"])
>          self.console_wait("Full name")
> -        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_send("%s\n" % self._config["guest_user"])
>          self.console_wait_send("Uid",                   "\n")
>          self.console_wait_send("Login group",           "\n")
>          self.console_wait_send("Login group",           "\n")
> @@ -148,9 +148,9 @@ class FreeBSDVM(basevm.BaseVM):
>          self.console_wait_send("Use an empty password", "\n")
>          self.console_wait_send("Use a random password", "\n")
>          self.console_wait("Enter password:")
> -        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_send("%s\n" % self._config["guest_pass"])
>          self.console_wait("Enter password again:")
> -        self.console_send("%s\n" % self.GUEST_PASS)
> +        self.console_send("%s\n" % self._config["guest_pass"])
>          self.console_wait_send("Lock out",              "\n")
>          self.console_wait_send("OK",                    "yes\n")
>          self.console_wait_send("Add another user",      "no\n")
> @@ -164,12 +164,12 @@ class FreeBSDVM(basevm.BaseVM):
>=20=20
>          # setup qemu user
>          prompt =3D "$"
> -        self.console_ssh_init(prompt, self.GUEST_USER, self.GUEST_PASS)
> +        self.console_ssh_init(prompt, self._config["guest_user"], self._=
config["guest_pass"])
>          self.console_wait_send(prompt, "exit\n")
>=20=20
>          # setup root user
>          prompt =3D "root@freebsd:~ #"
> -        self.console_ssh_init(prompt, "root", self.ROOT_PASS)
> +        self.console_ssh_init(prompt, "root", self._config["root_pass"])
>          self.console_sshd_config(prompt)
>=20=20
>          # setup serial console
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index cdac502dad8..dc0e45c1d45 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -120,24 +120,24 @@ class NetBSDVM(basevm.BaseVM):
>          self.console_wait_send("d: Change root password",  "d\n")
>          self.console_wait_send("a: Yes",                   "a\n")
>          self.console_wait("New password:")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>          self.console_wait("New password:")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>          self.console_wait("Retype new password:")
> -        self.console_send("%s\n" % self.ROOT_PASS)
> +        self.console_send("%s\n" % self._config["root_pass"])
>=20=20
>          self.console_wait_send("o: Add a user",            "o\n")
>          self.console_wait("username")
> -        self.console_send("%s\n" % self.GUEST_USER)
> +        self.console_send("%s\n" % self._config["guest_pass"])

Can you see where we went wrong ;-)

<snip>

--=20
Alex Benn=C3=A9e

