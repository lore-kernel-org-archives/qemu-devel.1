Received: from eggs.gnu.org ([209.51.188.92]:42686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1glrBg-0004Ox-Oa
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1glrBd-00082D-8I
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:13:36 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:34203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1glrBc-000805-2X
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:13:32 -0500
References: <154809778688.10764.12505763850198799463.reportbug@deadeye.wl.decadent.org.uk>
	<16ee5e20-e61b-7242-7d80-39a06fb8fd4f@msgid.tls.msk.ru>
	<d4f70494-732f-1013-291c-c56566d10c57@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <31f25a38-e22d-6e08-f0a5-2b8ed7c3dea8@vivier.eu>
Date: Tue, 22 Jan 2019 09:13:02 +0100
MIME-Version: 1.0
In-Reply-To: <d4f70494-732f-1013-291c-c56566d10c57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Bug#920032: qemu-user uses wrong struct timeval on
 sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, 920032@bugs.debian.org

On 22/01/2019 07:12, Thomas Huth wrote:
>  Hi Ben,
> 
> could you please submit this as a proper patch to the qemu-devel mailing
> list, with Signed-off-by line?
> (see https://wiki.qemu.org/Contribute/SubmitAPatch for details)
> 
>  Thanks,
>   Thomas
> 
> 
> On 2019-01-22 06:42, Michael Tokarev wrote:
>> Forwarding to qemu-devel@.
>> http://bugs.debian.org/920032
>>
>> Thanks!
>>
>> 21.01.2019 22:09, Ben Hutchings wrote:
>>> Package: qemu-user
>>> Version: 1:3.1+dfsg-2
>>> Severity: important
>>> Tags: patch
>>>
>>> On sparc (only) Linux defines timeval::tv_usec with type int, not
>>> long.  However qemu-user's definition of struct target_timeval uses
>>> abi_long unconditionally.  This results in the syscall translation
>>> layer effectively multiplying tv_usec by 2**32.  All sparc syscalls
>>> passing non-zero values for this field fail with -EINVAL.  The
>>> following patch seems to fix this.
>>>
>>> Ben.
>>>
>>> --- a/linux-user/syscall_defs.h
>>> +++ b/linux-user/syscall_defs.h
>>> @@ -210,7 +210,11 @@ struct target_linger {
>>>     struct target_timeval {
>>>       abi_long tv_sec;
>>> +#if defined (TARGET_SPARC)

According to the kernel definition, I think it should be:

#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)

See include/uapi/linux/time.h

struct timeval {
        __kernel_time_t         tv_sec;         /* seconds */
        __kernel_suseconds_t    tv_usec;        /* microseconds */
};

and arch/sparc/include/uapi/asm/posix_types.h

#if defined(__sparc__) && defined(__arch64__)
...
typedef int                    __kernel_suseconds_t;


>>> +    abi_int tv_usec;
>>> +#else
>>>       abi_long tv_usec;
>>> +#endif
>>>   };
>>>     struct target_timespec {
>>> --- END ---
>>>
>>> -- System Information:
>>> Debian Release: buster/sid
>>>    APT prefers unstable-debug
>>>    APT policy: (500, 'unstable-debug'), (500, 'stable-updates'), (500,
>>> 'unstable'), (500, 'testing'), (500, 'stable'), (1, 'experimental')
>>> Architecture: amd64 (x86_64)
>>> Foreign Architectures: i386
>>>
>>> Kernel: Linux 4.19.0-1-amd64 (SMP w/4 CPU cores)
>>> Locale: LANG=en_GB.UTF-8, LC_CTYPE=en_GB.UTF-8 (charmap=UTF-8),
>>> LANGUAGE=en_GB.UTF-8 (charmap=UTF-8)
>>> Shell: /bin/sh linked to /bin/dash
>>> Init: systemd (via /run/systemd/system)
>>> LSM: AppArmor: enabled
>>>
>>> Versions of packages qemu-user depends on:
>>> ii  libc6         2.28-3
>>> ii  libcapstone3  3.0.5-3
>>> ii  libgcc1       1:8.2.0-13
>>> ii  libglib2.0-0  2.58.1-2
>>> ii  libstdc++6    8.2.0-13
>>> ii  zlib1g        1:1.2.11.dfsg-1
>>>
>>> Versions of packages qemu-user recommends:
>>> ii  qemu-user-static [qemu-user-binfmt]  1:3.1+dfsg-2
>>>
>>> Versions of packages qemu-user suggests:
>>> ii  sudo  1.8.26-2
>>>
>>> -- no debconf information
>>>
>>
> 
> 
