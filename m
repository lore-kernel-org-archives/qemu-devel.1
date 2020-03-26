Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248ECC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37692073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd/3s3iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37692073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSXS-0001co-47
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHSWW-0001Dn-CE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHSWV-00035V-6e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:26:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHSWV-00035N-39
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJkiRaFCdvkppVqpvetDjDycyN885KO3GRsG6SOZAlo=;
 b=fd/3s3iOfR9WXa0Pg1EqCC6vj/9gqnO3+MZaYXJKPH1LbgO7GrPWiLmtPpa2C9kw58cyop
 3he8Qjqop5ZZpueqUpQnLWBXvcyclS7gELoDMdlzxqXpqxkgXU4y2zQ+n0tWaTf9tWiz7L
 m+iYiAL7MRt9zNqdjfWg1yLNxDF5TTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-HeEBxP0xNga6W1UXUpXCeQ-1; Thu, 26 Mar 2020 09:26:10 -0400
X-MC-Unique: HeEBxP0xNga6W1UXUpXCeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1244B100727C;
 Thu, 26 Mar 2020 13:26:09 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F8E5D9CD;
 Thu, 26 Mar 2020 13:26:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
To: "Hu, Robert" <robert.hu@intel.com>, Robert Hoo
 <robert.hu@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
References: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
 <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
 <9eea6e9c-e35c-72e7-4574-7b9a6b72f9a7@redhat.com>
 <9E79D1C9A97CFD4097BCE431828FDD31178F147A@SHSMSX104.ccr.corp.intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6c9cee4c-8d3b-ed9d-7345-fbaea33477ca@redhat.com>
Date: Thu, 26 Mar 2020 08:26:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9E79D1C9A97CFD4097BCE431828FDD31178F147A@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 9:09 PM, Hu, Robert wrote:
> (Don't know why my Linux-Evolution missed this mail.)
>> -----Original Message-----

>> Long line; it's nice to wrap commit messages around column 70 or so (bec=
ause
>> reading 'git log' in an 80-column window adds indentation).
>>
> [Hu, Robert]
> I think I set my vim on wrap. This probably escaped by paste.
> I ran checkpatch.pl on the patches before sending. It escaped check but d=
idn't
> escaped your eagle eye=F0=9F=98=8A Thank you.

checkpatch doesn't flag commit message long lines.  Maybe it could be=20
patched to do so, but it's not at the top of my list to write that patch.

>=20
>>> I just fix a boudary case on his original patch.
>>
>> boundary
> [Hu, Robert]
> Emm... again spell error. Usually I would paste descriptions into some ed=
itors
> with spell check, but forgot this time.
> Vim doesn't have spell check I think. What editor would you suggest me to
> integrate with git editing?

I'm an emacs user, so I have no suggestions for vim, but I'd be very=20
surprised if there were not some vim expert online that could figure out=20
how to wire in a spell-checker to vim.  Google quickly finds:=20
https://www.ostechnix.com/use-spell-check-feature-vim-text-editor/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


