Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF0C5ACBF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A83B206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCWpy1Yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A83B206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCN8b-0007st-Dd
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCN7e-00071w-Qf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCN7d-0002FQ-SP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:39:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCN7d-0002C3-Of
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584016773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4u0ARXBOOjRkmyDUxjIdK7Z/PrHSRPoVtYkAYpiZPOA=;
 b=HCWpy1Yd6/YZ4TbKzpA6z0qizQ121cFERWoJJvQHjhYQbqqbpGxxyaMW33YM1/8vN9QrNM
 l6Al8yFnCClOmC9iVWUHfihERDkPlLmGoLstFjaD5yinlZcVCKLqhbz35d0pKomVseiRZ+
 /Gum7Abm0fC6LN7+LolAiZ+HXjz31Dc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-38vnkmqhMEGO6DL8wW1GOA-1; Thu, 12 Mar 2020 08:39:31 -0400
X-MC-Unique: 38vnkmqhMEGO6DL8wW1GOA-1
Received: by mail-qv1-f69.google.com with SMTP id l16so3561019qvo.15
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SqD3nHGu4u2AXQdHC0AEcTziOjxXa7v1m2dDVrXB5wI=;
 b=MA31Jl+j2KCOJWDox+r9n/zEGRQY5wwfO3Dbwm2/fes4CoahPmfcXm9GvItUiSJX+S
 WD0oVHN464Y66V1TpEZwjMi/bTLmV2vJu/tBruS6PgJBxoran2NH9R5gUnVB7acG+87B
 7+jkso8PQ1lkUr0dGM2DmcLfxKuGbmYNE7YGqwZpYy7oEMsuTVD2Lr8Y4p3579y7qwb0
 YnUWUDDRgPUc43UVzr+sjoYy+A4xpt27rPJChfZnceaj1HKtVbaxkxt/XjlrKua6l+IH
 ASX981KxDhQNsgvG3BBb8lF3IjOV21RxmIgz1SlmDO8yl8i7RkOdbKbvBxXT1I00onEr
 Uqbw==
X-Gm-Message-State: ANhLgQ2j/gcQ6+diA3uIfEAsWm21W5mTOitunHVgdgVNSb9p4J1hOesj
 Th6zZ5+GXNaw3px1TFqDsYkfWvsot+3a1Rt8XnL2ifC+JLcP+fp4Hvr1IQZHx66I58X0e4DIzBt
 nrGWcJKGD7DMaQqA=
X-Received: by 2002:ac8:6f19:: with SMTP id g25mr7248451qtv.346.1584016771298; 
 Thu, 12 Mar 2020 05:39:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUHZAHLjPL6Icz29/ZCse9sVOFwgS5HzyiG1k99Wr3CR2DrBElMkvH64gXtdluFI7ZfumKHA==
X-Received: by 2002:ac8:6f19:: with SMTP id g25mr7248434qtv.346.1584016771111; 
 Thu, 12 Mar 2020 05:39:31 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id f22sm5666346qto.79.2020.03.12.05.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:39:30 -0700 (PDT)
Date: Thu, 12 Mar 2020 08:39:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
Message-ID: <20200312083845-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
 <20200311161819-mutt-send-email-mst@kernel.org>
 <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
 <20200312031427-mutt-send-email-mst@kernel.org>
 <CAOEp5Od=GW1onOqchw3H8nYSUByuekYCvi6jsWO8v9SYiFF27Q@mail.gmail.com>
 <20200312042252-mutt-send-email-mst@kernel.org>
 <CAOEp5OdEAku2EZncVKVOHk++0GwMyUiNOGDA22_7S8Whcekqaw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdEAku2EZncVKVOHk++0GwMyUiNOGDA22_7S8Whcekqaw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 11:08:20AM +0200, Yuri Benditovich wrote:
> Michael, just tell me please what you want:
> You prefer to change everywhere ' virtio_net_config' to 'virtio_net_confi=
g_rss'
> and two month later to change it back?

Exactly.

> You prefer to change everywhere=A0 ' virtio_net_config'=A0 to 'VIRTIO_NET=
_CONFIG'
> and define it according to the needs?

I can live with this too, if you prefer this.

> Something other?


