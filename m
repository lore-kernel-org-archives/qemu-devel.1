Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257CBC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21FA21721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzITEtts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21FA21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafnq-00075U-31
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaeyQ-0003KX-MS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaeyL-0000Rq-PC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:02:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaeyL-0000Oy-Hm
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575028924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09lOm2d0Z6P6U4KAbWDiXZg7WKQjTZqYIf3Hv51a2N4=;
 b=NzITEttslX+zDzWCWvZgIatIP2RU6fCYowTrHhl7SXPds2MI6AsXPjsoR4e/eNQqv+8Jxu
 TEvSqjWgDHQXPhY03aRyG51GxkG01jiGWv1xOE2OTW/WWmIT/H78qR/HxTnVBKQPj4zvro
 kAvX7JLcrhRF/+VCIP+v1ZCnMJXmgZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-kG1zZJGnNOiFYpcna6e37A-1; Fri, 29 Nov 2019 07:01:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20A010054E3;
 Fri, 29 Nov 2019 12:01:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB2F7600C8;
 Fri, 29 Nov 2019 12:01:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B0371138606; Fri, 29 Nov 2019 13:01:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
 <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
Date: Fri, 29 Nov 2019 13:01:54 +0100
In-Reply-To: <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com> (Paolo
 Bonzini's message of "Fri, 29 Nov 2019 11:11:09 +0100")
Message-ID: <87imn2uc0d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kG1zZJGnNOiFYpcna6e37A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/11/19 11:07, Igor Mammedov wrote:
>>>> So user who wants something non trivial could override default
>>>> non-numa behavior with
>>>>   -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,s=
hare=3Don \
>>>>   -machine memdev=3Dmem
>>>> or use any other backend that suits theirs needs. =20
>>> That's nice, but not as friendly as a simple -mem-shared.
>> (I still do not like idea of convenience options but it won't
>> get onto the way much if implemented as "global property" to memdev,
>> so I won't object if there is real demand for it)
>
> I agree with Igor, we should always think about the generic ("object
> model") options and only then add convenience option.

+1

[...]


