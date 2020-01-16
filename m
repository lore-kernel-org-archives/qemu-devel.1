Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3895C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E5A2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXtIZI5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E5A2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9Op-0003X9-HW
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1is9NN-0002Jl-P6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1is9NH-00076p-IB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:56:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1is9NH-00075r-ES
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579197365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IdZXlu082V6/G1amvwikNthsAXTAb+FmdqdKwex6ys=;
 b=CXtIZI5Vw/m+Lv3lZ5ti4XO+NWussa/wlds8/2oGMcO3UJWfkAiPI1XbBGYZe2YC+DZdWG
 3Kpcp8w2cmbye+puny4p2LlqSQozVbVIlRnj1fRmtyxNEZzoOAsgmQJmOUebO9JYESbabW
 QmCa9qiIcHefylYYNQ3WvsCcT8X36BY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-sxl_ZeaKNfqbS95lX3mtgg-1; Thu, 16 Jan 2020 12:56:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so9485202wrp.8
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 09:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=1FSsd8tZFQTz/R4vAsZTNKgoTgDg6mbKNJsq4vLG4eA=;
 b=GqrjOzGNdBXoxMBfijU6e2XJK8ak+UDjqZG9JalJ6sHLObEM1z/bJfmyomqYQIpEA/
 MqaIW2rMH7pmp7fXxAnZQYLAudpZV6KiNgeW65+Z/nPncMzy35C6DUp0GIRpDFVUt6RE
 e8159OsEbC0vLt/+H0PUO98Q97vpVZAYtdQAckIA3bySH68tLaZ0sejKVef4+GPF/umE
 JdNGvp2a3+ZAj7IHVRMnAPhLEMZjR4p5Zbxrz3zGia/U/Mu1RH0jgzZE2sb+Aymi1pUl
 F3fYU42vj2SyHjHr4G26MrjJvcMhWF/18H6ldzJtfdzqltHp6N6fDzAvmq73bGFoYC0K
 yuXQ==
X-Gm-Message-State: APjAAAVu8lYK0azwfL5/NbR+vl0RvMhqB0Ld4cMqskaSu+BdzCbvtjvb
 O6zz4xKXrDqIuJzab4+3ZCrVXfJ4eiPKffu2YAWLo4TMc1wW+GaVbxk+afp+QtaYfxBarO1BKzc
 i76YqwBc96pe0fio=
X-Received: by 2002:a1c:4004:: with SMTP id n4mr188986wma.153.1579197363208;
 Thu, 16 Jan 2020 09:56:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQ7grfu07dY0d0PiHhy/GHPX7sQDgvIQ72afLdHUBe9TDGSxEEipfU0Z5jL+pIAY9IqKoxUA==
X-Received: by 2002:a1c:4004:: with SMTP id n4mr188968wma.153.1579197362994;
 Thu, 16 Jan 2020 09:56:02 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:616d:b873:b647:711c?
 ([2a01:e0a:466:71c0:616d:b873:b647:711c])
 by smtp.gmail.com with ESMTPSA id 25sm5370372wmi.32.2020.01.16.09.56.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Jan 2020 09:56:02 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Extraneous nesting in QAPI schema
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <87r214qk98.fsf@dusky.pond.sub.org>
Date: Thu, 16 Jan 2020 18:56:00 +0100
Message-Id: <45FBD7A4-0F25-41EE-98EA-139970BDD166@redhat.com>
References: <87r214qk98.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: sxl_ZeaKNfqbS95lX3mtgg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 16 Dec 2019, at 17:59, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Kevin suggested to investigate a more generic flattening solutions.
>=20
> Of course, flattening is only possible as long as there are no name
> clashes.

Or you could reverse the name sequence and allow
the =E2=80=9Cupper=E2=80=9D layers to disambiguate.

backend.data.addr.type -> type.addr.data.backend
other.data.addr.data.type -> type.data.addr.data.other

then =E2=80=9Ctype=E2=80=9D would match both, could be disambiguated with
type.other or type.backend, or even type.o or type.b.

That way, you could have some generic way to disambiguate
for the rare cases you need it.



