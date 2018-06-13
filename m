Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT99V-0000jo-SE
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT99R-0003B1-Uo
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:01:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT99R-00039Q-QE
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:01:41 -0400
References: <20180611203712.12086-1-ehabkost@redhat.com>
	<a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
	<20180612150153.GK7451@localhost.localdomain>
	<6c9b3744-7323-cd1f-7b07-2b77df7ae80d@redhat.com>
	<20180612182541.GN7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b93cd6e5-bb2e-b932-bc68-da5c314924a2@redhat.com>
Date: Wed, 13 Jun 2018 19:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180612182541.GN7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] i386: Remove ospke CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 12/06/2018 20:25, Eduardo Habkost wrote:
> On Tue, Jun 12, 2018 at 05:12:58PM +0200, Paolo Bonzini wrote:
>> On 12/06/2018 17:01, Eduardo Habkost wrote:
>>>>>
>>>>> Remove OSPKE from the feature name array so users don't try to
>>>>> configure it manually.
>>>>>
>>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Yes, it's the same as OSXSAVE.  Thanks!
>>> CR4_OSXSAVE_MASK is automatically enabled on user-mode QEMU,
>>> though.
>>>
>>> My question is if it would make any sense to enable CR4_PKE_MASK
>>> too.
>>
>> If you mean OSPKE, then yes---if PKU is available.  Likewise, OSXSAVE
>> should only be enabled if XSAVE is available.
> 
> Yeah, I mean enabling it only if PKU is available, like we
> already do with OSXAVE/XSAVE.
> 
> But we don't do it today, so enabling it automatically in
> CONFIG_USER_ONLY would be a new feature.  Would it be useful for
> anything, though?
> 
> I'm asking that to find out if somebody could be already using
> "-cpu ...,+ospke" with user-mode QEMU today (which this patch
> would break).  If RDPKRU/WRPKRU is useless under user-mode QEMU,
> than we don't need to worry about that.

Hmm, actually there are two more things to consider for user-mode emulation.

First, QEMU doesn't support any of pkey_mprotect, pkey_alloc, pkey_free,
so it should probably never set OSPKE.

Second, for user-mode emulation it makes sense to allow flipping of
OSPKE and OSXSAVE, because that corresponds to different behaviors of
the underlying kernels.  There have been bugs in fact with programs that
incorrectly tested XSAVE instead of OSXSAVE, so it's worthwhile to let
the user test both configurations.

So to sum up, the default for QEMU user-mode emulation should be
OSXSAVE=XSAVE and OSPKE=0.

Paolo
