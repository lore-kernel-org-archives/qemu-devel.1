Received: from eggs.gnu.org ([2001:4830:134:3::10]:41369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1eCR3q-0008UV-Vl
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1eCR3n-0007Hm-Qm
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:10:34 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:54710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slopezpa@redhat.com>) id 1eCR3n-0007HQ-Eg
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:10:31 -0500
Received: by mail-vk0-f43.google.com with SMTP id n70so1767073vkf.11
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 06:10:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
References: <20171108063447.2842-1-slp@redhat.com>
	<f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 8 Nov 2017 15:10:30 +0100
Message-ID: <CAAiTLFV80SfMneuhs7tdYENOb+zV7kJ43B9ZgALk2tva1ZDpUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] util/async: use atomic_mb_set in
 qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org

On Wed, Nov 8, 2017 at 2:50 PM, Pavel Butsykin <pbutsykin@virtuozzo.com> wrote:
> On 08.11.2017 09:34, Sergio Lopez wrote:
>> This was considered to be safe, as the completion function restarts the
>> loop just after the call to qemu_bh_cancel. But, under certain access
>> patterns and scheduling conditions, the loop may wrongly use a
>> pre-fetched elem->state value, reading it as THREAD_QUEUED, and ending
>> the completion function without having processed a pending TPE linked at
>> pool->head:
>
>
> I'm not quite sure that the pre-fetched is involved in this issue,
> because pre-fetch reading a certain addresses should be invalidated by
> write on another core to the same addresses. In our case write
> req->state = THREAD_DONE should invalidate read req->state == THREAD_DONE.
> I am inclined to think that there is a memory-reordering read with
> write. It's a very real case for x86 and I don't see the reasons which
> can prevent it:
>

Yes, you're right. This is actually a memory reordering issue. I'm
going to rewrite that paragraph.

Thanks Pavel.
