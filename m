Received: from eggs.gnu.org ([2001:4830:134:3::10]:33455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJm8N-0007Bj-JO
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJm8M-0004Vs-ID
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:05:35 -0500
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
	<20171113161446.2862-2-michael.nawrocki@gtri.gatech.edu>
	<CAFEAcA8FDoLRx+OCMwjUzYd-X3HX7Z77SUTmNbSB9YWYT77AcA@mail.gmail.com>
	<CAFEAcA-JwUm5+N-Km1fZjuPYA81sMCekguchJiV59BvqjnPJOA@mail.gmail.com>
	<b3a7006b-bf0d-f5f3-bf78-f18b38a014e7@gtri.gatech.edu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb039f59-f43b-88c7-324e-31a336a8d433@redhat.com>
Date: Tue, 28 Nov 2017 14:05:25 -0600
MIME-Version: 1.0
In-Reply-To: <b3a7006b-bf0d-f5f3-bf78-f18b38a014e7@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Switch AMD CFI flash to use new
 MMIO API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 11/28/2017 01:47 PM, Michael Nawrocki wrote:
>>> I suspect you'll find that the change of type for 'ret' here
>>> and the 'value' argument to pflash_write() will break compilation
>>> with PFLASH_DEBUG defined, because the type won't match the DPRINTF
>>> format strings any more.
>>>
>>> You could either fix up the format strings, or (since there's a
>>> wrapper function here anyway) leave the types of pflash_read()
>>> and pflash_write() alone and let the wrappers implicitly do
>>> the conversion between uint64_t and uint32_t.
>>
>> ...ah, just noticed that in patch 2 you want to add 8-byte
>> accesses. So you'll need to fix the format strings.
>>
>> thanks
>> -- PMM
>>
> 
> Yeah, it definitely doesn't compile with PFLASH_DEBUG defined. I'll 
> update those format strings for the next revision.

Better yet, please fix the PFLASH_DEBUG code to avoid bitrot in the 
first place, by rewriting the bad pattern:

/* #define PFLASH_DEBUG */
#ifdef PFLASH_DEBUG
#define DPRINTF(fmt, ...)                                   \
do {                                                        \
     fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
} while (0)
#else
#define DPRINTF(fmt, ...) do { } while (0)
#endif

into the good pattern:

#ifdef PFLASH_DEBUG
# define PFLASH_PRINT 1
#else
# define PFLASH_PRINT 0
#endif
#define DPRINTF(fmt, ...) \
do { \
   if (PFLASH_PRINT) { \
     fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__); \
   }; \
} while (0)

or even better, using the trace infrastructure instead.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
