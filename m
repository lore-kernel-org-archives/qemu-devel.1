Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB2C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF92208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE7syLfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF92208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBeWp-00061y-C7
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBeVj-000525-2R
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBeVe-00008L-5r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:01:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBeVe-00007E-0d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583845281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIgXjft8KmBHkZcaXWmehB6HzZfEVlkCJpRN82kVNQU=;
 b=OE7syLfS1DPNmH4OadvK27HU3KIixSMmwwsceCfFxAqo0LhXsRrDUQNGv3LsbMSfy6ndDw
 jZtiMmaT9Sc3bGCqtNlqhSyvDLQA/xi4ybFZ+1btx4JIGpmhpX6T7BKKvVcqHyhP8E0/0q
 ZaNAQKET13/sv3ucPIb9wJVl7418Gr0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-MhV3zRk4P3ODLaEwMjMJ_A-1; Tue, 10 Mar 2020 09:01:19 -0400
X-MC-Unique: MhV3zRk4P3ODLaEwMjMJ_A-1
Received: by mail-qv1-f70.google.com with SMTP id d7so8997063qvq.12
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 06:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HR7jxFz1hK9qPqO6fIvuvR/Q01S/1UQnbGNVJLDB1Og=;
 b=eGy6CQgrUA6JC3pRpH1Q4RjiRtGZzX/dH6MORHQLur7HG84SuGoNfGOXih6LeBNxk2
 8YUILrwR7tFZ1qN4y8G+xYQw9XmwD09LTSpbbZ8UrQJ2uauXBaoLaqhlhH13luC6S1iy
 rvYBO6jjWWyPV/8avl3PvwdgLLrKA9OlK9gUz4NngSwxLzN1+2zvum6TFTq7ionRfGNz
 5eem+fUdJlI4r79vXgDQmMuE6K4DNUs/k0dxZUGZAk15d0cOnaE2kwF/yS6msnaI57dh
 hWhdaoIZCDbglnEfc+AdKTc//NUX3IgsUCIjwSK0MWeBJEz3/8bjTEsZsvBgJnQ/KBJc
 /Jnw==
X-Gm-Message-State: ANhLgQ3GugbU1Cr/c/6z2sRyogS/0E93foXgm4S2zMee/8xzAJwIT0Al
 Tfn0VoOwDRUllNImdmSsR5tEKEJa3S4NVEQcejyp4V9MDEyN17+dlKcENYmCcsrC5HvhRxLQkmt
 W48KMoTv/bQhrYF8=
X-Received: by 2002:a05:620a:22cd:: with SMTP id
 o13mr10821856qki.160.1583845278175; 
 Tue, 10 Mar 2020 06:01:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtO2gLbwwpGjEu18N2XQ3ZK8yml92/wo1dJjzcKhd7VB872goh1/adqDmvXmd5QcR6IqhPC9A==
X-Received: by 2002:a05:620a:22cd:: with SMTP id
 o13mr10821829qki.160.1583845277944; 
 Tue, 10 Mar 2020 06:01:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id f19sm15847313qtp.46.2020.03.10.06.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 06:01:16 -0700 (PDT)
Date: Tue, 10 Mar 2020 09:01:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Message-ID: <20200310085932-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310052226-mutt-send-email-mst@kernel.org>
 <c9374d4c-4d63-9302-0896-958950029ec5@oracle.com>
 <20200310074821-mutt-send-email-mst@kernel.org>
 <e47b9099-301c-d742-b17f-9a61982ee93f@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e47b9099-301c-d742-b17f-9a61982ee93f@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 02:37:07PM +0200, Liran Alon wrote:
> So I think you are right this should be le32_to_cpu(). i.e. Treat the
> uuid_part[x] as little-endian and convert it to native CPU format.
>=20
> I always get confused in this :)
>=20
> Thanks,
> -Liran

Yes - Linux has tagging for this so one knows what's going on, and
sparse can catch errors.  Unfortunately QEMU does not use this
capability. A nice (not so little) project for someone :)

--=20
MST


