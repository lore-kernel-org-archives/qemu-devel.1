Received: from eggs.gnu.org ([2001:4830:134:3::10]:50139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cehhb-0002In-1J
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cehha-0001bg-7u
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:31:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1323841238.24175066.1487331028566.JavaMail.zimbra@redhat.com>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
	<w51poihqggo.fsf@maestria.local.igalia.com>
	<1323841238.24175066.1487331028566.JavaMail.zimbra@redhat.com>
Date: Fri, 17 Feb 2017 13:31:44 +0100
Message-ID: <w51mvdlq9qn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, dgilbert@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, quintela@redhat.com, mreitz@redhat.com

On Fri 17 Feb 2017 12:30:28 PM CET, Pankaj Gupta wrote:
>> >  To maintain consistency at all the places use qemu_madvise wrapper
>> >  inplace of madvise call.
>> 
>> > -        madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
>> > +        qemu_madvise((uint8_t *) t + offset, length, QEMU_MADV_DONTNEED);
>> 
>> Those two calls are not equivalent, please see commit
>> 2f2c8d6b371cfc6689affb0b7e for an explanation.

> I don't understand why '2f2c8d6b371cfc6689affb0b7e' explicitly changed
> for :"#ifdef CONFIG_LINUX" I think its better to write generic
> function maybe in a wrapper then to conditionally set something at
> different places.

The problem with qemu_madvise(QEMU_MADV_DONTNEED) is that it can mean
different things depending on the platform:

   posix_madvise(POSIX_MADV_DONTNEED)
   madvise(MADV_DONTNEED)

The first call is standard but it doesn't do what we need, so we cannot
use it.

The second call -- madvise(MADV_DONTNEED) -- is not standard, and it
doesn't do the same in all platforms. The only platform in which it does
what we need is Linux, hence the #ifdef CONFIG_LINUX and #if
defined(__linux__) that you see in the code.

I agree with David's comment that maybe it's better to remove
QEMU_MADV_DONTNEED altogether since it's not reliable.

Berto
