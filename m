Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3108C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF45E20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwiKLlAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF45E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rjA-0003jH-TN
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j9raA-0005Ct-AH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j9ra8-0005l2-1t
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:34:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j9ra7-0005ko-V9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krX3gDbpIAPOR6Dt66bZ4ORH7zF5XP/GGnCiX9UoZtI=;
 b=ZwiKLlAgDu62iHbCBVV5/TTcTX4PBI+6pHzA6sfqbVe7IfjeS2hsz/zrn5V2j1cGvB0y3M
 ZL2XKBCZ2CkcYgs0yZP3L9eSf3KsRYiCxNOx16qcjr1M1C38uy2SFkbIcJZO/C8H8JWxQu
 Jh33JfrBvrVVeCk0x/vfygqHSoCU4p0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-RHk3sziXMoqANvyLxvZjhw-1; Thu, 05 Mar 2020 09:34:32 -0500
X-MC-Unique: RHk3sziXMoqANvyLxvZjhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE174189F760;
 Thu,  5 Mar 2020 14:34:30 +0000 (UTC)
Received: from [10.3.117.177] (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A712272D3;
 Thu,  5 Mar 2020 14:34:26 +0000 (UTC)
Subject: Re: [PATCH v2 0/9] hw, ui, virtfs-proxy-helper: Reduce QEMU
 .data/.rodata/.bss footprint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
 <20200305134229.GB2112347@redhat.com>
 <a7c0746f-75dc-99ed-62df-26f26cf23ec0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <daf7eac5-1796-06f0-1e95-ee86d50d629f@redhat.com>
Date: Thu, 5 Mar 2020 08:34:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a7c0746f-75dc-99ed-62df-26f26cf23ec0@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 7:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/5/20 2:42 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Mar 05, 2020 at 01:45:16PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Since v1:
>>> - merged 2 series
>>> - reworked hw/usb/quirks
>>> - added R-b/A-b tags
>>>
>>> This series reduce the footprint of the QEMU binary:
>>> .bss: 106KiB (moved to .heap)
>>
>> Did this actually have an impact on the binary size, or just on the
>> size the elf-dissector reports ?=C2=A0 I'm not very familiar with ELF,
>> but Wikipedia's description of BSS makes me question it...
>>
>> =C2=A0=C2=A0 "Typically only the length of the bss section, but no data,
>> =C2=A0=C2=A0=C2=A0 is stored in the object file. The program loader allo=
cates
>> =C2=A0=C2=A0=C2=A0 memory for the bss section when it loads the program.=
 On
>> =C2=A0=C2=A0=C2=A0 some platforms, some or all of the bss section is ini=
tialized
>> =C2=A0=C2=A0=C2=A0 to zeroes. Unix-like systems and Windows initialize t=
he bss
>> =C2=A0=C2=A0=C2=A0 section to zero"
>>
>> This suggests .bss has no on-disk overhead, only runtime overhead,
>> which is presumably going to be the same with heap allocations.
>=20
> IIUC when stored in the .bss, the buffer are always allocated in memory,=
=20
> even if not used. By moving them to the .heap, we only allocate them=20
> when using either the adlib audio device or curses.

Virtual memory is cheap on 64-bit platforms.  Just because the address=20
range is reserved does not actually change the amount of memory in use=20
by the machine, if the application does not touch those virtual=20
addresses.  But you do have a potential point on a 32-bit platform,=20
where a heap allocation only when needed may avoid address space=20
exhaustion for other cases.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


