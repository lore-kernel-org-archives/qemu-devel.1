Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA77DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9BD20788
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsygbSVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9BD20788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkmp-0004Mk-Q0
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGklz-0003iu-Ja
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGkly-0002NN-A6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:43:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGkly-0002MT-4S
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585060997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPjBJRKhOqOSpxx5TF+f/eHTf7tEnWqyIEKpzllrkfc=;
 b=BsygbSVe9aEBCO5ocbwORvmkmjrD4q1DpHarFVLfKE+iM0GI+m6CrOD1+soLhVvyDUpxdM
 uqkSAuvxQ8cLiPB2tGAo8+QUKRqZtck/NHtHsaHofH1EWzjm1tdLT/AK2vhaHgPuQGsuWq
 vQTz+hd7b9LL5yxS9xb6miXcPU3GnwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-sqCD4Tb8Mxqg948W2wkIzA-1; Tue, 24 Mar 2020 10:43:15 -0400
X-MC-Unique: sqCD4Tb8Mxqg948W2wkIzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94373477;
 Tue, 24 Mar 2020 14:43:14 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B8B69128E;
 Tue, 24 Mar 2020 14:43:13 +0000 (UTC)
Subject: Re: [PATCH 2/3] iotests: Add poke_file_[bl]e functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200227170251.86113-1-mreitz@redhat.com>
 <20200227170251.86113-3-mreitz@redhat.com>
 <473f2e22-bf5b-32f4-51db-bf12f7a2d4fe@redhat.com>
 <16d049db-8952-0e6b-5021-3f212712d70d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6dff0289-f9e4-4eb6-7972-bd37379f744c@redhat.com>
Date: Tue, 24 Mar 2020 09:43:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <16d049db-8952-0e6b-5021-3f212712d70d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On 3/10/20 12:22 PM, Max Reitz wrote:
>>>  =C2=A0 +# poke_file_le 'test.img' 512 2 65534
>>> +poke_file_le()
>>> +{
>>
>> I like the interface.=C2=A0 However, the implementation is a bit bloated=
 (but
>> then again, that's why you cc'd me for review ;)
>>
>>> +=C2=A0=C2=A0=C2=A0 local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D''

Noticing that this is not in yet, I have one more suggestion:

The initial doc comment is not helpful without reading the rest of the=20
function: Is 512 the offset or the value being written?  Better might be:

# poke_file_le test.img $offset $width $value


>>> +
>>> +# poke_file_be 'test.img' 512 2 65279
>>> +poke_file_be()

and here, too.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


