Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D041C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3535420705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJsG5a4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3535420705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCUU-0001yi-CS
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipCOU-0002E0-40
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipCOS-0006XI-MH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:33:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipCOS-0006W9-Hv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578493988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD9tAS2fqOSiRhQDHrCuTc8J1fkQfGMjR3EfUfcFYtw=;
 b=TJsG5a4puA6mcspZDxEWqAlRwD2R1/AmfRUvLKXvhsf7oJlB6eWzLviUbQu4Sv388PYmq4
 mjY8cKYsiJKD7Iv4VfmSxTexwUcGb9FgCCoofCbCU1nvUtyP75d10FAU4T1pzSTI4EoYmm
 ovTRWDWmhnkt4FMaT1yrQt6itP4HiGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-LeVe1WNAMkCSKs6lB1DbWg-1; Wed, 08 Jan 2020 09:33:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so1487903wrm.23
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y+ZFrQt/4O+BcLCiuqUiQqazBu6klP4jSOde9XUsOFw=;
 b=VetOAUUFZAX5MYUUJdhc5Kj8QfQaR23ov6DPC6qZR5lsNPYZAGMNtPssT3Y3soNgj6
 Q+Pnwv183sB2SEppIWj0H964HK3tz6NybFkpZDKBjejZ3w+jL+q3r37kiR+9StYQ/4Cp
 9uxtDJdejnl4kcMuQdgUFU0s9OF8kpF/NHfLidNGM276u3aP0xYZE2Wzv06MWVC9EQeK
 bprb7C/wFbSG0ut7lNXmqLjrAcV09E3h0IVmWnz8v502eEfNUrFoM1fopZ3JIpu6823t
 oo3aNcZHiBLrp22uuWTTZLU7085hu6WxYj6j/QQnD6KhSJBWTj5hk0K4pve8V3lVFghh
 ac5Q==
X-Gm-Message-State: APjAAAXmQZ9Lh1PbNicmBkB18WlEg1XqLdZimWOS0uyZ3Vdnzjvp7M4o
 XIeduhq97IjRTCu92rTUn0NaJIRAwWIwDR+WtPJVp0glF8I7rt1WV4g305CJXuxSHHbnbD8x01L
 g9STzGOEUw1fZQs0=
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr4689715wrv.291.1578493983551; 
 Wed, 08 Jan 2020 06:33:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6CXCRZmhgl9+VAA7oWDpAiUd74kyYrpt7cTpVMPRtu0qHVbiUYZWZn1jjtgHrPMwuKfPS7A==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr4689689wrv.291.1578493983287; 
 Wed, 08 Jan 2020 06:33:03 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id i11sm4542120wrs.10.2020.01.08.06.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:33:02 -0800 (PST)
Subject: Re: [PATCH v2] tests: fix test-qga on macosx
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1578490555-6363-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aca7f275-71ab-f634-72b7-915b70d42935@redhat.com>
Date: Wed, 8 Jan 2020 15:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578490555-6363-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: LeVe1WNAMkCSKs6lB1DbWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 2:35 PM, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Fix Unix socket connection & skip commands that are not implemented.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/Makefile.include |  2 +-
>   tests/test-qga.c       | 25 ++++++++++++++++++-------
>   2 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 49e3b0d..192a08e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -119,7 +119,7 @@ check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-sec=
ret$(EXESUF)
>   check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/tes=
t-crypto-tlscredsx509$(EXESUF)
>   check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/tes=
t-crypto-tlssession$(EXESUF)
>   ifneq (,$(findstring qemu-ga,$(TOOLS)))
> -check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tes=
ts/test-qga$(EXESUF)
> +check-unit-$(call land,$(CONFIG_POSIX),$(CONFIG_VIRTIO_SERIAL)) +=3D tes=
ts/test-qga$(EXESUF)
>   endif
>   check-unit-y +=3D tests/test-timed-average$(EXESUF)
>   check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index d2b2435..191bfca 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -17,17 +17,17 @@ typedef struct {
>  =20
>   static int connect_qga(char *path)
>   {
> -    int s, ret, len, i =3D 0;
> +    int s, ret, i =3D 0;
>       struct sockaddr_un remote;

Or
         struct sockaddr_un remote =3D { };
and remove memset().

Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>       s =3D socket(AF_UNIX, SOCK_STREAM, 0);
>       g_assert(s !=3D -1);
>  =20
> +    memset(&remote, 0, sizeof(struct sockaddr_un));
>       remote.sun_family =3D AF_UNIX;
>       do {
> -        strcpy(remote.sun_path, path);
> -        len =3D strlen(remote.sun_path) + sizeof(remote.sun_family);
> -        ret =3D connect(s, (struct sockaddr *)&remote, len);
> +        strncpy(remote.sun_path, path, sizeof(remote.sun_path) - 1);
> +        ret =3D connect(s, (struct sockaddr *)&remote, sizeof(struct soc=
kaddr_un));
>           if (ret =3D=3D -1) {
>               g_usleep(G_USEC_PER_SEC);
>           }
> @@ -305,6 +305,7 @@ static void test_qga_info(gconstpointer fix)
>       qobject_unref(ret);
>   }
>  =20
> +#if defined(CONFIG_LINUX)
>   static void test_qga_get_vcpus(gconstpointer fix)
>   {
>       const TestFixture *fixture =3D fix;
> @@ -324,7 +325,9 @@ static void test_qga_get_vcpus(gconstpointer fix)
>  =20
>       qobject_unref(ret);
>   }
> +#endif
>  =20
> +#if defined(CONFIG_LINUX)
>   static void test_qga_get_fsinfo(gconstpointer fix)
>   {
>       const TestFixture *fixture =3D fix;
> @@ -348,6 +351,7 @@ static void test_qga_get_fsinfo(gconstpointer fix)
>  =20
>       qobject_unref(ret);
>   }
> +#endif
>  =20
>   static void test_qga_get_memory_block_info(gconstpointer fix)
>   {
> @@ -394,6 +398,7 @@ static void test_qga_get_memory_blocks(gconstpointer =
fix)
>       qobject_unref(ret);
>   }
>  =20
> +#if defined(CONFIG_LINUX)
>   static void test_qga_network_get_interfaces(gconstpointer fix)
>   {
>       const TestFixture *fixture =3D fix;
> @@ -412,6 +417,7 @@ static void test_qga_network_get_interfaces(gconstpoi=
nter fix)
>  =20
>       qobject_unref(ret);
>   }
> +#endif
>  =20
>   static void test_qga_file_ops(gconstpointer fix)
>   {
> @@ -682,7 +688,7 @@ static void test_qga_blacklist(gconstpointer data)
>       qobject_unref(ret);
>  =20
>       /* check something work */
> -    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
> +    ret =3D qmp_fd(fix.fd, "{'execute': 'guest-info'}");
>       qmp_assert_no_error(ret);
>       qobject_unref(ret);
>  =20
> @@ -766,6 +772,7 @@ static void test_qga_config(gconstpointer data)
>       g_key_file_free(kf);
>   }
>  =20
> +#if defined(CONFIG_LINUX)
>   static void test_qga_fsfreeze_status(gconstpointer fix)
>   {
>       const TestFixture *fixture =3D fix;
> @@ -781,6 +788,7 @@ static void test_qga_fsfreeze_status(gconstpointer fi=
x)
>  =20
>       qobject_unref(ret);
>   }
> +#endif
>  =20
>   static void test_qga_guest_exec(gconstpointer fix)
>   {
> @@ -976,12 +984,17 @@ int main(int argc, char **argv)
>       g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
>       g_test_add_data_func("/qga/ping", &fix, test_qga_ping);
>       g_test_add_data_func("/qga/info", &fix, test_qga_info);
> +#if defined(CONFIG_LINUX)
>       g_test_add_data_func("/qga/network-get-interfaces", &fix,
>                            test_qga_network_get_interfaces);
>       if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
>           g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus=
);
>       }
>       g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
> +    g_test_add_data_func("/qga/fsfreeze-status", &fix,
> +                         test_qga_fsfreeze_status);
> +#endif
> +
>       g_test_add_data_func("/qga/get-memory-block-info", &fix,
>                            test_qga_get_memory_block_info);
>       g_test_add_data_func("/qga/get-memory-blocks", &fix,
> @@ -993,8 +1006,6 @@ int main(int argc, char **argv)
>       g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob=
);
>       g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd=
);
>       g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_ar=
gs);
> -    g_test_add_data_func("/qga/fsfreeze-status", &fix,
> -                         test_qga_fsfreeze_status);
>  =20
>       g_test_add_data_func("/qga/blacklist", NULL, test_qga_blacklist);
>       g_test_add_data_func("/qga/config", NULL, test_qga_config);
>=20


