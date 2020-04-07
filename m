Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E263AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E31206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPLN4UY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E31206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrwo-0002eF-Sa
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jLrvy-0001Wv-Fa
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jLrvx-0001e0-G7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:22:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jLrvx-0001di-Ch
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586280164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cv7xA6w6QvGJ3nuzCWRu3TQuvdHUeqDsWDaXLeu5O7E=;
 b=MPLN4UY1CsOYgo/VyXsw8hwhQoP7uHY2oyg9CIet5ygwRZUJE30CyZOE7gvXgES5Nux5Lv
 UX0+TVpdTZYAQ7xiqq+Jm1GLuOfgM2h4qeH0u+gpvbLa7sQdNibat96ZwtuU/ttI5yipD2
 6PsoZHzHomFa2uG4vZcfySwwagrm3EQ=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-gmNZhwswMkyko7qIVPJo8w-1; Tue, 07 Apr 2020 13:22:43 -0400
X-MC-Unique: gmNZhwswMkyko7qIVPJo8w-1
Received: by mail-ua1-f72.google.com with SMTP id 77so1488127uaj.8
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 10:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Awh6ULP1pIjgeUsRq1bmrb4LNEYLj6ZkdZkk97RR0hA=;
 b=jmYXzQSv1tzTc0giR9wbFqc5T3VqvTtdNK3MZCMaz1l0YezeAwYMlldHQrf1H4VW4E
 s0HFo4TOO9cqrrA+j+P3WWXuQ/iF9QDpsmswGSvqH5KwqQgZP5pvSpwRhOfenb71r6NO
 s8mUNSx3prSsKeDb2QxkX5WBEuXhRcxSdjN8X+KKpXsfHBs7tQ4KOl95xGwmcSl3Uu+4
 dMX6a0xsC08KzD8+Sm6eoHD5QJ2I7X1yLRMGhKFPadesYz6cgf0cMn/EB9evjJ1wdLcf
 61KliyO+MUSnn+MfoS4H0bXvrpHYUt4iQZck87yQf0Bfdtg+teu89q2xB3gMF6McqPJU
 GriQ==
X-Gm-Message-State: AGi0Pub5sKtu/y5LuvMqbhUmGk/SYdBIyMAtLDMlV7AVEP4/VOxSagFA
 v8ggtolWaQyRJSP5u8umINK8ECDpV9IcmCWH4OhNhO6cFQjRyehJfLwG99Py1DX2aWZv4yyrgdb
 /HvbpFIiKrSnToWuufvMyzbEMZ81P5a8=
X-Received: by 2002:a1f:4312:: with SMTP id q18mr2285860vka.27.1586280162574; 
 Tue, 07 Apr 2020 10:22:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypK2oB32nn06K6NBA6ItNG/NsSbLyi+oXyT1Wl/SNPzhIXE599yXDBvlkEIADKdmdKYulHs/bcrPJ8KFjGr7IiU=
X-Received: by 2002:a1f:4312:: with SMTP id q18mr2285855vka.27.1586280162302; 
 Tue, 07 Apr 2020 10:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200407155642.10716-1-ovoshcha@redhat.com>
 <20200407155642.10716-4-ovoshcha@redhat.com>
In-Reply-To: <20200407155642.10716-4-ovoshcha@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 7 Apr 2020 14:22:31 -0300
Message-ID: <CAKJDGDb3cg2svLA2ayw9oLmr8iA0Q9xPdEYVeG2DhToDgmn_kA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Acceptance test: provides to use RDMA transport
 for migration test
To: Oksana Vohchana <ovoshcha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Philippe Mathieu Daude <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 7, 2020 at 1:07 PM Oksana Vohchana <ovoshcha@redhat.com> wrote:
>
> Adds test for RDMA migration check
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>  tests/acceptance/migration.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index 1c3a684395..99563ae850 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -120,3 +120,15 @@ class Migration(Test):
>          """
>          free_port =3D self._get_free_port()
>          dest_uri =3D 'exec:nc -l localhost %u' % free_port
> +
> +    @skipUnless(get_rdma_status(), 'RDMA service is disabled or not inst=
alled')
> +    @skipUnless(get_interface_rdma(), 'RDMA interface not configured')
> +    def test_migration_with_rdma_localhost(self):
> +        iface =3D get_interface_rdma()
> +        ip =3D get_ip_rdma(iface)
> +        if ip:
> +            free_port =3D self._get_free_port(address=3Dip[0])
> +        else:
> +            self.cancel("Ip address doesn't configured properly on inter=
face:%s" % iface)
> +        dest_uri =3D 'rdma:%s:%u' % (ip, free_port)
> +        self.do_migrate(dest_uri)
> --
> 2.21.1
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


