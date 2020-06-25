Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88B620773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1I79Ueg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88B620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joJp1-0006uQ-7R
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 00:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joJoQ-0006Tb-4h
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:48:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57873
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joJoM-0005ET-Vu
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593060510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPrE7WePYSzK39F43/Mo1OXbAQKIjPQ/rbCOYeXlWPA=;
 b=A1I79Ueg3qjwdPNtrL1D11OrV/p7iZI7bu3k1oqoKXJ3nwkfKrvBsZ4QKgAluzIECZkaq0
 bdDz0Wn6mioNoJQFYL2LT0vJVoObGZUAxkNjOerXfNYfATmyYsCfd4oafCkvgKXj2qERxW
 1D+IxPlsP9/whgDgoqoTkGBMZIokyAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-sKUx2r8aPLSB9cGnFg8PGQ-1; Thu, 25 Jun 2020 00:48:27 -0400
X-MC-Unique: sKUx2r8aPLSB9cGnFg8PGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E720A107ACCA;
 Thu, 25 Jun 2020 04:48:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80073100EBB8;
 Thu, 25 Jun 2020 04:48:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0959F11384D4; Thu, 25 Jun 2020 06:48:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v1 00/10] vDPA support in qemu
References: <20200622153756.19189-1-lulu@redhat.com>
 <877dvy45vr.fsf@dusky.pond.sub.org>
 <CACLfguWUoV7Ngt0U3Rdenvyp1s0PcWk2xsJirYGvHR3KSmZoeA@mail.gmail.com>
 <c8929663-27f2-93d6-e7b5-a3dc269fa7d2@redhat.com>
 <CACLfguW04Lz8jbe+HOPMk7V46A91USc7eo+XdP+3BX+OeOFzDA@mail.gmail.com>
Date: Thu, 25 Jun 2020 06:48:15 +0200
In-Reply-To: <CACLfguW04Lz8jbe+HOPMk7V46A91USc7eo+XdP+3BX+OeOFzDA@mail.gmail.com>
 (Cindy Lu's message of "Wed, 24 Jun 2020 17:42:56 +0800")
Message-ID: <87v9jf7nu8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cindy Lu <lulu@redhat.com> writes:

> On Tue, Jun 23, 2020 at 5:43 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>>
>> On 2020/6/23 =E4=B8=8B=E5=8D=885:16, Cindy Lu wrote:
>> > On Tue, Jun 23, 2020 at 3:07 PM Markus Armbruster <armbru@redhat.com> =
wrote:
>> >> Cindy Lu <lulu@redhat.com> writes:
>> >>
>> >>> vDPA device is a device that uses a datapath which complies with the
>> >>> virtio specifications with vendor specific control path. vDPA device=
s
>> >>> can be both physically located on the hardware or emulated by softwa=
re.
>> >>> This RFC introduce the vDPA support in qemu
>> >>> TODO
>> >>> 1) vIOMMU support
>> >>> 2) live migration support
>> >> This gives me the foggiest of ideas on what vDPA is.  Could we use
>> >> docs/interop/vhost-vdpa.rst?
>> >>
>> > Sure will add this
>> >
>> >
>>
>> Not sure it's the best place since vhost-vdpa is kernel specific.
>>
>> Maybe kernel docs (TBD) is a better place and we can refer it this file
>> in the future.
>>
>> But it doesn't harm if you said something more here and refer the kernel
>> commit here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D4c8cf31885f69e86be0b5b9e6677a26797365e1d
>>
>> Thanks
>>
>>
> Hi Markus,
> I think I agree with Jason's opinion, kernel docs is a better place.
> Maybe we can keep what it is now, and do this job in the future.

I think a super-short description of vDPA here (one sentence?) together
with a link to complete information would be helpful.  If the link's
target doesn't yet exist, adding the link later is okay.


