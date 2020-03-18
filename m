Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B54C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504DE20757
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUCzXt3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504DE20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEaUj-0002mJ-EO
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 11:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEaU1-0002L6-Up
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEaU0-0003cV-G1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:19:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEaU0-0003Vh-8I
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584544787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oD4ebzrcvOsCJTYeIZlelN0wKyiJ6XixffotJeNmGP0=;
 b=JUCzXt3c6LfoyN7pzNfh7VIRzhV6ZemoLTU8om0xNhsUga+0EuYGj8FNya6Pv5FB+jiWDl
 EqOkcWgUm5s8OvaQ7sP5F+4TUqY5tzfsTeMJDyOQQIBAcQbP/XmE9HzMUjjDpdFDRGi5/M
 7BAI1uYxA5SED+caZT3XgV4xVz1Qdrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-dPdB1YdoNuu0pgMC8D_6Ag-1; Wed, 18 Mar 2020 11:19:45 -0400
X-MC-Unique: dPdB1YdoNuu0pgMC8D_6Ag-1
Received: by mail-wm1-f70.google.com with SMTP id z26so1176529wmk.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 08:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P3aEI7MWjY2Fri1Ho2EcAhF8sP9NkUSCzssC1DeA61c=;
 b=qB7w8gZ5vN9gSIuNJZVywvBzbraB+C4Oa25zCVxz1Xo8o/9VXdEoqMQmTos9ry0Y3v
 4js1yMh3GfKMn1VX8bhs4RZRn31SzGPLGRm91yLLejtRAOcWKDc9mu63q21I9rQq9W5d
 EgkWoWNDYbjn6dQYzI3olw8ZprxLKIO3zX7CKP4DkHVybzVzY9CC0DYOml1Vm41NqC8j
 t0bu/HJec0LTlysjElf/5GQDm2CFCmx4DY27Jm/jkColgA8rfoCR1hvHKv2dbqF195/Q
 9RkpcO6/MGIk1TAv2kM1PL21H0aDSq6Bg/xxNHT91KNdXSmZbJZxKwJjXtFrZOGBcKa2
 mwzQ==
X-Gm-Message-State: ANhLgQ10++p6DpLwYcLy5Px2yHQLnXpY8YNdglAwzez80SGOTbFRyQ9r
 thJ+rJXs5Xllg5h+qerAagAeInRtaCRFOZcccHnuh9AyRv8LeAXlkz7pQXrHM8VLA4DH3Bia3u4
 K21pE0oZ9b2cBC0s=
X-Received: by 2002:adf:e511:: with SMTP id j17mr6483149wrm.25.1584544784536; 
 Wed, 18 Mar 2020 08:19:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vucnLyuAMZuh2k1iDg47Y103rPXHMQObLQL0gozs2ZHJJMHfWFkLan7j+pa2AHImsFSUXTpFQ==
X-Received: by 2002:adf:e511:: with SMTP id j17mr6483131wrm.25.1584544784229; 
 Wed, 18 Mar 2020 08:19:44 -0700 (PDT)
Received: from redhat.com (bzq-109-66-39-109.red.bezeqint.net. [109.66.39.109])
 by smtp.gmail.com with ESMTPSA id a7sm3680359wmb.0.2020.03.18.08.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 08:19:43 -0700 (PDT)
Date: Wed, 18 Mar 2020 11:19:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC
 macro
Message-ID: <20200318111857-mutt-send-email-mst@kernel.org>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-7-yuri.benditovich@daynix.com>
 <87d099g6j6.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <87d099g6j6.fsf@secure.laptop>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: yan@daynix.com, Yuri Benditovich <yuri.benditovich@daynix.com>,
 jasowang@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 02:02:37PM +0100, Juan Quintela wrote:
> Yuri Benditovich <yuri.benditovich@daynix.com> wrote:
> > Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
> > 16-bit field.
> >
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
> Same caveat about attribution to MST.
>=20
> Once told tha, I don't understand why you are using a unit16_t.
> You define indirections_len as:
>=20
> +    uint16_t indirections_len;
>=20
> But its maximum value right now is:
>=20
> +#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
>=20
> So, are we planning to increase that value in the next future, or we
> just want to give enough space?
>=20
> Later, Juan.

The max size according to spec is u16. Using that limits
the size and makes it forward compatible.


