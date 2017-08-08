Received: from eggs.gnu.org ([2001:4830:134:3::10]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df48T-0001Wd-8k
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df48O-00053k-Jy
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:01:25 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170802105704.m2jbxnivl32msbx6@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
	<20170802103922.GE5531@stefanha-x1.localdomain>
	<20170802105704.m2jbxnivl32msbx6@postretch>
Date: Tue, 08 Aug 2017 15:01:10 +0200
Message-ID: <w51y3qujjs9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Wed 02 Aug 2017 12:57:04 PM CEST, Manos Pitsidianakis wrote:
>> At the moment I think throttle_groups_lock isn't strictly needed
>> because incref/decref callers hold the QEMU global mutex anyway.
>>
>> But code accessing throttle_groups still has to be disciplined.
>> Since throttle_groups_lock exists, please use it consistently in all
>> code paths.
>>
>> Alternatively you could remove the lock and document that
>> throttle_groups is protected by the global mutex.  What we can't do
>> is sometimes use throttle_groups_lock and sometimes not use it.
>
> If we use throttle_groups_lock in throttle_group_obj_init() then we
> must give it up in throttle_group_incref() and retake it in
> throttle_group_obj_init(). Maybe indeed it's better to drop
> throttle_groups_lock altogether, since the ThrottleGroup refcounting
> always happens in a QMP or startup/cleanup context.

I checked the code and I also don't see any manipulation of the group
list outside the global mutex, so you can remove throttle_groups_lock,
but please document very clearly that all these calls can only happen
when they are protected by the global mutex.

Berto
