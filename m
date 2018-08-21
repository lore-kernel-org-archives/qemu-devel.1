Received: from eggs.gnu.org ([2001:4830:134:3::10]:46234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs386-0008TM-PJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs381-0002Of-Lt
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:39:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fs381-0002NR-CM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:39:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so2224219wmq.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 02:39:08 -0700 (PDT)
References: <20180818025653.21192-1-f4bug@amsat.org>
	<66dfe354-9c2c-8642-a905-03155555fe99@redhat.com>
	<a812530c-ad1b-f5ff-6e15-82227cb76c79@redhat.com>
	<2fd04596-a8a0-889f-239d-92853c12c6aa@redhat.com>
	<2d91d7e2-938d-dbbe-5a11-edf48d4e0fc8@redhat.com>
	<eca82595-47c6-a195-8224-6a9f6619decd@redhat.com>
	<e7a5018b-a480-4a5d-d305-cd69a007a452@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d941c0c3-1ac6-442d-3b43-370ec1d9b00c@redhat.com>
Date: Tue, 21 Aug 2018 11:39:04 +0200
MIME-Version: 1.0
In-Reply-To: <e7a5018b-a480-4a5d-d305-cd69a007a452@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 21/08/2018 08:03, Thomas Huth wrote:
>>> gcc is not necessarily wrong, as it CAN catch real erroneous uses of 
>>> strncpy().  It's just that 99% of the time, strncpy() is the WRONG 
>>> function to use, and so the remaining few cases where it actually does 
>>> what you want are so rare that you have to consult the manual anyways. 
>>> If nothing else, the gcc warning is making people avoid strncpy() even 
>>> where it is safe (which is not a bad thing, in my opinion, because the 
>>> contract of strncpy() is so counter-intuitive).
>>>
>> I am wondering if we should simply add a helper for these special cases
>> that zeroes the buffer and uses g_strlcpy(), instead of
>> ignoring/disabling the warning.
> Yes, a helper function with a proper comment about its purpose is likely
> the best way to go.

But why use g_strlcpy in the function (which has an off-by-one effect)?

Maybe it could be a qemu_strncpy that is the same as strncpy but returns
-ERANGE if the source is longer than the buffer that is passed in (but
not if it fits perfectly without a terminating NUL):

    int qemu_strncpy(const char *d, const char *s, int dsize)
    {
        while (*s && dsize) {
            *d++ = *s++;
            dsize--;
        }
        /* It's okay if D is just past the end of the buffer,
         * and S is sitting on the terminating NUL.
         */
        if (*s) {
            return -ERANGE;
        }
        while (dsize) {
            *d++ = 0;
        }
        return 0;
    }

Then we have the problem of yet another incomplete transition, but at
least we could convert those that GCC complains about.

Paolo
