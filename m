Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F2C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521D222525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM5kEcsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521D222525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icv25-0001xH-HJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icv0O-00013D-ES
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icv0I-0006UZ-0n
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:33:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icv0G-0006RY-3e
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575567201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXeZyo48H3SZ9vKNo89jpscEKcAmkJ65SmGcOay8P6g=;
 b=RM5kEcsHTyKGqFH/bUVeQ/6BF21N4sYuxtXzS+eTI3lGX4lGttc7l0Dfb8jq1BNyj1arxD
 ueUym+D+NjRmW057UswGMBxm0eSloq2SGlaZrSSJcW2F7hzl14akl+LzBXP1y90QfAQgDB
 4lf3whKZYtpLj8TMUoUdh3Xh3g0/J8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-gkHur7j6PiOysEy_2vMLcg-1; Thu, 05 Dec 2019 12:33:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7409E800D41;
 Thu,  5 Dec 2019 17:33:16 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 885356012D;
 Thu,  5 Dec 2019 17:32:42 +0000 (UTC)
Subject: Re: [RFC v5 024/126] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-25-vsementsov@virtuozzo.com>
 <87muc8p24w.fsf@dusky.pond.sub.org>
 <55393c08-5bda-8042-1a95-f350b3781d99@virtuozzo.com>
 <87d0d3c5k7.fsf@dusky.pond.sub.org>
 <eef60af5-ff92-3df7-bad5-c981690d66ad@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <54c19813-8a10-1607-6fdc-cd7d930ecac7@redhat.com>
Date: Thu, 5 Dec 2019 11:32:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eef60af5-ff92-3df7-bad5-c981690d66ad@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gkHur7j6PiOysEy_2vMLcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 "sheepdog@lists.wpkg.org" <sheepdog@lists.wpkg.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Liu Yuan <namei.unix@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Anthony Green <green@moxielogic.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "integration@gluster.org" <integration@gluster.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 8:58 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> What about you provide the examples, and then I try to polish the prose?
>>>
>>> 1: error_fatal problem
>>>
>>> Assume the following code flow:
>>>
>>> int f1(errp) {
>>>       ...
>>>       ret = f2(errp);
>>>       if (ret < 0) {
>>>          error_append_hint(errp, "very useful hint");
>>>          return ret;
>>>       }
>>>       ...
>>> }
>>>
>>> Now, if we call f1 with &error_fatal argument and f2 fails, the program
>>> will exit immediately inside f2, when setting the errp. User will not
>>> see the hint.
>>>
>>> So, in this case we should use local_err.
>>
>> How does this example look after the transformation?

Without ERRP_AUTO_PROPAGATE(), the transformation is a lot of boilerplate:

int f1(errp) {
     Error *err = NULL;
     ret = f2(&err);
     if (ret < 0) {
         error_append_hint(&err, "very useful hint");
         error_propagate(errp, err);
         return ret;
     }
}

what's worse, that boilerplate to solve problem 1 turns out to be...

> 
> Good point.
> 
> int f1(errp) {
>      ERRP_AUTO_PROPAGATE();
>      ...
>      ret = f2(errp);
>      if (ret < 0) {
>         error_append_hint(errp, "very useful hint");
>         return ret;
>      }
>      ...
> }
> 
> - nothing changed, only add macro at start. But now errp is safe, if it was
> error_fatal it is wrapped by local error, and will only call exit on automatic
> propagation on f1 finish.
> 
>>
>>> 2: error_abort problem
>>>
>>> Now, consider functions without return value. We normally use local_err
>>> variable to catch failures:
>>>
>>> void f1(errp) {
>>>       Error *local_err = NULL;
>>>       ...
>>>       f2(&local_err);
>>>       if (local_err) {
>>>           error_propagate(errp, local_err);
>>>           return;
>>>       }
>>>       ...
>>> }

the very same code as the cause of problem 2.

>>>
>>> Now, if we call f2 with &error_abort and f2 fails, the stack in resulting
>>> crash dump will point to error_propagate, not to the failure point in f2,
>>> which complicates debugging.
>>>
>>> So, we should never wrap error_abort by local_err.
>>
>> Likewise.
> 
> And here:
> 
> void f1(errp) {
>       ERRP_AUTO_PROPAGATE();
>       ...
>       f2(errp);
>       if (*errp) {
>           return;
>       }
>       ...
> 
> - if errp was NULL, it is wrapped, so dereferencing errp is safe. On return,
>     local error is automatically propagated to original one.

So, the use of ERRP_AUTO_PROPAGATE() solves BOTH problems 1 and 2 - we 
avoid the boilerplate that trades one problem for another, by 
consolidating ALL of the boilerplate into a single-line macro, such that 
error_propagate() no longer needs to be called anywhere except inside 
the ERRP_AUTO_PROPAGATE macro.

> 
>>
>>>
>>> ===
>>>
>>> Our solution:
>>>
>>> - Fixes [1.], adding invocation of new macro into functions with error_appen_hint/error_prepend,
>>>      New macro will wrap error_fatal.
>>> - Fixes [2.], by switching from hand-written local_err to smart macro, which never
>>>      wraps error_abort.
>>> - Handles [3.], by switching to macro, which is less code
>>> - Additionally, macro doesn't wrap normal non-zero errp, to avoid extra propagations
>>>      (in fact, error_propagate is called, but returns immediately on first if (!local_err))
>>
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


