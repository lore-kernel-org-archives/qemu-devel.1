Received: from eggs.gnu.org ([2001:4830:134:3::10]:59987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebB7H-0005NZ-PH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebB7E-0002ph-Hn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:12:23 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c4c78a3f-39c4-fe06-c151-db1e4f9009aa@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1509551048-129830-9-git-send-email-anton.nefedov@virtuozzo.com>
	<w511sirt9ya.fsf@maestria.local.igalia.com>
	<c4c78a3f-39c4-fe06-c151-db1e4f9009aa@virtuozzo.com>
Date: Mon, 15 Jan 2018 21:12:17 +0100
Message-ID: <w51wp0ihof2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 08/15] qcow2: skip writing zero buffers
 to empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Mon 15 Jan 2018 07:21:01 PM CET, Anton Nefedov wrote:
>>>       /**
>>> +     * Indicates that both COW areas are empty (nb_bytes == 0)
>>> +     * or filled with zeroes and do not require any more copying
>>> +     */
>>> +    bool zero_cow;
[...]
>>> -    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
>>> +    if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->zero_cow) {
>>>           return 0;
>>>       }
>> 
>> Here, 'if (m->zero_cow)' would suffice.
>
> The thing is, zero_cow is not assigned on some code paths,
> e.g. !(bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE)
> or when bs->encrypted.

Right, that's why I said that the comment on the zero_cow field is
incorrect, zero_cow does not indicate when nb_bytes == 0.

> but now thinking about this again; probably it should be - that will
> be least confusing. I'll fix

Choose the simplest solution, as long as the documentation matches the
semantics.

Berto
