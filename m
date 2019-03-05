Received: from eggs.gnu.org ([209.51.188.92]:53135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1GhU-0000jG-Jm
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 15:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1GhT-0000xi-Oc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 15:30:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1GhT-0000pF-Gm
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 15:30:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so10925196wrw.6
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 12:30:01 -0800 (PST)
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
	<150efd5f-dea0-93bd-c74c-6d012f4ab7d1@redhat.com>
	<d8dd795b-1f4c-a802-e4ea-6cf06cdab5c6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4956a66a-a254-cd18-fe50-992ceb25028e@redhat.com>
Date: Tue, 5 Mar 2019 21:29:58 +0100
MIME-Version: 1.0
In-Reply-To: <d8dd795b-1f4c-a802-e4ea-6cf06cdab5c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3/5/19 9:08 PM, Eric Blake wrote:
> On 3/5/19 1:45 PM, Thomas Huth wrote:
> 
>>> If there are special instructions for what to do with
>>> build trees over the transition to kconfig, the pullreq
>>> cover letter would be a good place to mention them :-)
>>
>> I think you've got to do a "make distclean" inbetween... that's the old
>> problem when a default-configs/*.mak file gets added or erased - we do
>> not properly re-generate the dependencies in that case.
> 
> As in this?
> 
> upgrade path:
> build old commit
> make distclean
> git pull/branch/...

make distclean again?

> build new commit
> 
> downgrade path (when bisecting, backporting, ...)
> build new commit
> make distclean
> git branch/reset/...

make distclean again?

> build old commit
> 
> We obviously can't fix old commits to recognize when we are downgrading
> from a new commit, but is there anything we can do when upgrading to a
> newer commit to more gracefully inform the user if they forgot a 'make
> distclean' (or even better, to not make a 'make distclean' on upgrade
> mandatory)?  In particular, once this patch series lands, developers
> doing a blind 'git pull' will end up in the situation:
> 
> build old commit
> git pull
> build new commit # oops
> 
> but may not realize that they first have to reset back to the old commit
> prior to 'make distclean' to guarantee that it will work. Unless I'm
> mistaken and 'make distclean' on an incremental build will work in spite
> of the missing dependencies on *.mak files even when you forgot to clean
> before upgrading.
> 
> 'make distclean' is a heavy hammer, is there anything smaller in scope
> that will fix the problem without nuking everything, such as a strategic
> touch or rm of one particular file?
> 
