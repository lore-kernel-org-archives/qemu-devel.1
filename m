Received: from eggs.gnu.org ([2001:4830:134:3::10]:41233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV1xn-0007G5-Ir
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV1xm-0005iN-PO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:40:55 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dV1xm-0005i9-IN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:40:54 -0400
Received: by mail-wr0-x229.google.com with SMTP id c11so5126964wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:40:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711190846.GA3138@work-vm>
References: <20170709175422.30185-1-peter.maydell@linaro.org>
	<20170711162943.GF2223@work-vm>
	<CAFEAcA-JXT3B0uXbxbh9oex4gngsz350Sq+P4QK=aqAS9q1dcA@mail.gmail.com>
	<20170711190846.GA3138@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 21:40:32 +0100
Message-ID: <CAFEAcA-vXYOTm0o4V1XHf1ScuLO9RZesgM+v9FTA71qa9MeBwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a
 negative number in fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>

On 11 July 2017 at 20:08, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> [cc'd Eric as the sort of person
>>
>> On 11 July 2017 at 17:29, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> > * Peter Maydell (peter.maydell@linaro.org) wrote:
>> >> In a fork_exec() error path we try to closesocket(s) when s might
>> >> be a negative number because the thing that failed was the
>> >> qemu_socket() call. Add a guard so we don't do this.
>> >>
>> >> (Spotted by Coverity: CID 1005727 issue 1 of 2.)
>> >>
>> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> >> ---
>> >> Issue 2 of 2 in CID 1005727 is trickier -- we need to move as
>> >> much as possible of the client-end connect/accept out of the
>> >> child process and into the parent as possible. I'm not sure
>> >> if it's safe to do it all in the parent without deadlocking...
>> >
>> > or just bail earlier?
>>
>> The problem is you can only bail while you're in the parent
>> before forking. Once you've started the child there's no
>> mechanism for dealing with failure.
>
> Well, you can always exit the child before anything worse can happen.

You need a mechanism then for causing the parent to notice.
The current code would leave the parent in a blocking
accept() call forever (this is what all the XXX comments
in the current code are about).

thanks
-- PMM
