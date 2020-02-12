Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0088C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDB82082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfZCzOoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDB82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uOP-0000Qw-UI
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1uNq-0008Qj-N7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1uNo-0003Bw-Tr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:57:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1uNo-0003BD-P7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581523019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPn7z374ZwqN5hKkzmwu0P79yvK+s/QhU2sBOXrSONQ=;
 b=HfZCzOoiqtBNv/CAZbdikCU6FGeXaYDok02WdrOiVR+uH1JUC17fljKudw1vHPAfZPDYid
 P9mxSwW+1R3GlRQyVr/YMOI7bAb9896XpDM5FvUP3nwQdJ9oOBibOpLpmJ/TZhrhiTOJyO
 hNwATSkoEEZi8RiqYd+wsQi9MbC/3pk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-nK_dQYQEMB-9q49BzXweNA-1; Wed, 12 Feb 2020 10:56:53 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so991172wrp.8
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 07:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Klx62tK3IWHZWOXeIIQKYSaw8f9LtQojrWCYk5I1Vo=;
 b=pMA3eviLU0Pxe2uyx7vxny3ZRB5TRKpcSAUTxxbxn413FEh2tlqf9ZUqDh5qMAizBf
 Sc1RawqTSUO/peeC4t0fqMoCFxoy1GY7dZHXhLKGWtNCDxRU19581edmvUHsOCYYK7a3
 JHZP49fX7Dqcuaau09+TMwZQ2/kmNAaHxfOro8wbB4YxaZSy56HRQwLwzHwV6WN6dyLc
 OWA2Y13IP996wW/Kzh+dFaVZn3GNA61mz4uTNQdk2nWfjTwHMId7E8nMlOqlgy09Xl4I
 UClO4COKd2n2qxaAvhAD1whj5Sdld0tl21tH4UBx7lj0UE/3jwv3e0W0fQf/MOrZnsh+
 Uf6g==
X-Gm-Message-State: APjAAAVutUYYgxAtJk0gEXKFviPo0QMk1iqLe32W/mBpukHgL7b9CDu6
 5gNijOXY9MK+yuT7tGh3EcUCPrwSVXrL60szvm65jUACk0TuJzsSqng3GGgTtgz+We77sDG6Cl2
 pubgYmzYEC6vJKQ8=
X-Received: by 2002:a5d:6709:: with SMTP id o9mr15594892wru.82.1581523012226; 
 Wed, 12 Feb 2020 07:56:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqylJ8VnQ3s6QMzhBfV1YRFK23fffAeGi4Xn4ipYewA5qn6SaU6uB5kD8POz2DeOUzntIrw/9g==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr15594845wru.82.1581523011601; 
 Wed, 12 Feb 2020 07:56:51 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id m68sm1367788wme.48.2020.02.12.07.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 07:56:50 -0800 (PST)
Subject: Re: [PATCH v2] linux-user: implement TARGET_SO_PEERSEC
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200204211901.1731821-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <713318de-21ee-4137-0580-c6d852bea008@redhat.com>
Date: Wed, 12 Feb 2020 16:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204211901.1731821-1-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: nK_dQYQEMB-9q49BzXweNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Matthias_L=c3=bcscher?= <lueschem@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 10:19 PM, Laurent Vivier wrote:
> "The purpose of this option is to allow an application to obtain the
> security credentials of a Unix stream socket peer.  It is analogous to
> SO_PEERCRED (which provides authentication using standard Unix credential=
s
> of pid, uid and gid), and extends this concept to other security
> models." -- https://lwn.net/Articles/62370/
>=20
> Until now it was passed to the kernel with an "int" argument and
> fails when it was supported by the host because the parameter is
> like a filename: it is always a \0-terminated string with no embedded
> \0 characters, but is not guaranteed to be ASCII or UTF-8.
>=20
> I've tested the option with the following program:
>=20
>      /*
>       * cc -o getpeercon getpeercon.c
>       */
>=20
>      #include <stdio.h>
>      #include <sys/types.h>
>      #include <sys/socket.h>
>      #include <netinet/in.h>
>      #include <arpa/inet.h>
>=20
>      int main(void)
>      {
>          int fd;
>          struct sockaddr_in server, addr;
>          int ret;
>          socklen_t len;
>          char buf[256];
>=20
>          fd =3D socket(PF_INET, SOCK_STREAM, 0);
>          if (fd =3D=3D -1) {
>              perror("socket");
>              return 1;
>          }
>=20
>          server.sin_family =3D AF_INET;
>          inet_aton("127.0.0.1", &server.sin_addr);
>          server.sin_port =3D htons(40390);
>=20
>          connect(fd, (struct sockaddr*)&server, sizeof(server));
>=20
>          len =3D sizeof(buf);
>          ret =3D getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &len);
>          if (ret =3D=3D -1) {
>              perror("getsockopt");
>              return 1;
>          }
>          printf("%d %s\n", len, buf);
>          return 0;
>      }
>=20
> On host:
>=20
>    $ ./getpeercon
>    33 system_u:object_r:unlabeled_t:s0
>=20
> With qemu-aarch64/bionic without the patch:
>=20
>    $ ./getpeercon
>    getsockopt: Numerical result out of range
>=20
> With the patch:
>=20
>    $ ./getpeercon
>    33 system_u:object_r:unlabeled_t:s0
>=20
> Bug: https://bugs.launchpad.net/qemu/+bug/1823790
> Reported-by: Matthias L=C3=BCscher <lueschem@gmail.com>
> Tested-by: Matthias L=C3=BCscher <lueschem@gmail.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>=20
> Notes:
>      v2: use correct length in unlock_user()
>=20
>   linux-user/syscall.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d60142f0691c..c930577686da 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2344,6 +2344,28 @@ static abi_long do_getsockopt(int sockfd, int leve=
l, int optname,
>               }
>               break;
>           }
> +        case TARGET_SO_PEERSEC: {
> +            char *name;
> +
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            name =3D lock_user(VERIFY_WRITE, optval_addr, len, 0);
> +            if (!name) {
> +                return -TARGET_EFAULT;
> +            }
> +            lv =3D len;
> +            ret =3D get_errno(getsockopt(sockfd, level, SO_PEERSEC,
> +                                       name, &lv));

Can we get lv > len?

> +            if (put_user_u32(lv, optlen)) {
> +                ret =3D -TARGET_EFAULT;
> +            }
> +            unlock_user(name, optval_addr, lv);

Maybe safer to use len instead of lv here?

> +            break;
> +        }
>           case TARGET_SO_LINGER:
>           {
>               struct linger lg;
>=20


