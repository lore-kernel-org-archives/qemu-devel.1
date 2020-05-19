Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B38C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5832072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvrbrecF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5832072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0mZ-0005kC-Sq
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb0la-0004xI-1q
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:50:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb0lZ-0003QL-8Q
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589889036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxB0GrX6KEmTQiJjO1uFt6MvN5k+I7+bxPpLV7o0pQc=;
 b=fvrbrecFbrUHuHOpV15tJ/UNRTIXcEoYbsCimAX75yRDqXnP3i/annK6cLNgMTlaYjoqlN
 9fgZyTTVrd93PoWoCbNPGdqKkgbO8vbsoZ6iaKd/usHqLAtLF6u+BgNjkCYBwqRAXN/cHx
 5Na5kIOZ1sIfvbga3LsHczvOhGMtDrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-hiCrpsuINUyzonftCdqJ-A-1; Tue, 19 May 2020 07:50:32 -0400
X-MC-Unique: hiCrpsuINUyzonftCdqJ-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C7F8018AD;
 Tue, 19 May 2020 11:50:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF6982E73;
 Tue, 19 May 2020 11:50:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 155CD11358BC; Tue, 19 May 2020 13:50:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 11/24] pnv/phb4: Bury unwanted "pnv-phb4-pec-stack" devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-12-armbru@redhat.com>
 <defe5561-72b8-45a5-96b1-296df438fe38@kaod.org>
Date: Tue, 19 May 2020 13:50:27 +0200
In-Reply-To: <defe5561-72b8-45a5-96b1-296df438fe38@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Tue, 19 May 2020 10:16:05 +0200")
Message-ID: <87imgs2lfg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 5/18/20 7:03 AM, Markus Armbruster wrote:
>> The number of stacks is controlled by property "num-stacks".
>> pnv_pec_instance_init() creates the maximum supported number, because
>> the property has not been set then.  pnv_pec_realize() realizes only
>> the wanted number.  Works, although it can leave unrealized devices
>> hanging around in the QOM composition tree.  Affects machine powernv9.
>
> I have used this pattern in many models. Is there a better one ?

The pattern is just fine, we just need to unparent any devices that turn
out to be unwanted.

Of course, when we already know what's wanted at instance_init time,
there's no reason for creating more.


