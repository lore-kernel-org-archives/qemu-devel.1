Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED368C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B786920709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C656PCW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B786920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFK2G-0008K3-Ph
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jFK1M-0007sg-9J
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jFK1L-0003Iy-9z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:57:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jFK1L-0003Ie-6w
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584719834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEK1zRkTS2MEOHBTnlymO8SbfRPi9NvHNrsaHdc3+6A=;
 b=C656PCW4d6QJFj8XLZGkqUTZWcYcjHlRR0DMqhklndSIXGyYKO/UWJeIzW+nwxxP6gsRjq
 3SPmMozkdpybP/d1Yf7fFn7siDbR1Pl4CEafjJDG3jruQqzIZoHDSSHqy2U1y2YC8Rq5gi
 etAkW5ueklUxMfN/Fhn6lOi0quEV5lA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-mFxsWMaoPrC2u0bSG2tFBA-1; Fri, 20 Mar 2020 11:57:12 -0400
X-MC-Unique: mFxsWMaoPrC2u0bSG2tFBA-1
Received: by mail-wr1-f69.google.com with SMTP id e10so45136wrm.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 08:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tpYF+t4GMZ6LAUTnQySiTa1uEcvneZS4q2e422RjP+I=;
 b=QvEhJhAHV6xgSXkSjvXf+1cwYDrKGEs7XGM+ZUHaZfhWKJA476/l/lcoCfjxmNZcrd
 SPJ5yFe1TPnbg5+hpkRNL7Wup1LXXAY23WcGlCVPSlTs0OjWgDLZEIoBpLDZZvWQe4FL
 U85XZHHJm2Q8xJS0lUAHPr66d0OO8Fbyj8LVFd0Zqo99blSsUbEU682d4KwZccMlziKw
 aLSMT0w6/WDDTtwtvjVOdFSybMwBspbWL7BHP+zOwNTQ/UlL6DFY8DWaIceqTycBwAHF
 2lKnFWZxYziIWQPnWlL8zh0RYLQSOQ+P2ZvVwgWuYuk/fieYRs7PKv9clc8LxRcIFdmF
 1msg==
X-Gm-Message-State: ANhLgQ1F/L6wyrp2ftwUxDklepU9SdbopICrj/yJ6Y/eDSS607Madr7S
 j1ml47XLeeNP21IRu6nuGpX05bLLXKK5tbYVLjZMCBnvOLMpZOdwUqfU1lhhffpYC9c3M8QHGlT
 rmE2DkDWw2/tObSTSxDf4tN/l9+vNYz4=
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr10883408wmk.131.1584719831554; 
 Fri, 20 Mar 2020 08:57:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs3dB3igmpvkrR7YSKTuA7gDEoELrBFET0jpz06C86R1T1sLFC7ainlX/om+9VOjD68+nRUOSYuPOpO8ZQ8rpQ=
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr10883393wmk.131.1584719831352; 
 Fri, 20 Mar 2020 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200320151254.16766-1-ovoshcha@redhat.com>
 <20200320151254.16766-2-ovoshcha@redhat.com>
In-Reply-To: <20200320151254.16766-2-ovoshcha@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Fri, 20 Mar 2020 12:56:34 -0300
Message-ID: <CAKJDGDafd=6h_wY4aqZPxjx8YMj_jSqd+QUHasvig7RCz39ENg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Acceptance test: adds param 'address' in
 _get_free_port
To: Oksana Vohchana <ovoshcha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 12:15 PM Oksana Vohchana <ovoshcha@redhat.com> wrot=
e:
>
> In the migration test function _get_free_port works only for localhost,
> but in the case to use migration through an RDMA we need to get a free po=
rt
> on the configured network RDMA-interface.
> This patch is the start for another migration option
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>  tests/acceptance/migration.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a8367ca023..e4c39b85a1 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -52,8 +52,8 @@ class Migration(Test):
>          source_vm.qmp('migrate', uri=3Dsrc_uri)
>          self.assert_migration(source_vm, dest_vm)
>
> -    def _get_free_port(self):
> -        port =3D network.find_free_port()
> +    def _get_free_port(self, address=3D'localhost'):
> +        port =3D network.find_free_port(address=3Daddress)
>          if port is None:
>              self.cancel('Failed to find a free port')
>          return port
> --
> 2.21.1
>
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


