Received: from eggs.gnu.org ([2001:4830:134:3::10]:46528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etc0V-0004my-Vl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etc0T-0000BY-2U
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:33:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etc0S-0000B2-T4
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:33:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id z9so5852609wmb.3
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 08:33:32 -0800 (PST)
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
	<20180306134757.GH31045@stefanha-x1.localdomain>
	<20180306173718.GK7139@localhost.localdomain>
	<a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adaf915b-50fc-c0a4-a27f-12b9e609c14a@redhat.com>
Date: Wed, 7 Mar 2018 17:33:29 +0100
MIME-Version: 1.0
In-Reply-To: <a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 07/03/2018 16:57, Max Reitz wrote:
>>>> (2) For sparse raw images, this is absolutely devastating.  Reading them
>>>> now takes more than (ext4) or nearly (xfs) twice as much time as reading
>>>> a fully allocated image.  So much for "if a filesystem driver has any
>>>> sense".
>> Are you sure that only the filesystem is the problem? Checking for every
>> single byte of an image whether it is zero has to cost some performance.
> Well, yes, but "read data location from FS metadata" + "realize it's a
> hole" + memset() + "repe scasb" shouldn't take twice as much time as
> "read data location from FS metadata" + "read data from SSD".
> 
> I expected the "realize it's a hole" part to fall out for free, so this
> would that memset() + repe scasb take much longer than reading data from
> the SSD -- and that's just pretty much impossible.
> 

This makes a lot of sense, but just to double-check, what does profiling
say?

Paolo
