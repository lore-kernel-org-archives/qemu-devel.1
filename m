Received: from eggs.gnu.org ([2001:4830:134:3::10]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWNKi-0001fE-7w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWNKh-0004vP-Em
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:46:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fWNKh-0004vJ-9l
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:46:39 -0400
References: <20180621145749.191944-1-eblake@redhat.com>
	<CAFEAcA_6aJ705HdAD6b4m3fsGBGa6gEQXet5dkgc5aELxeknBw@mail.gmail.com>
	<CAFEAcA_0xjKVuSrUh5twc07=d-HPVoUc8JH9xunAapWCgpNreQ@mail.gmail.com>
	<5db29b95-c79b-9766-81c8-360cdd0a5b94@redhat.com>
	<CAFEAcA_DR6xftAT0wjbHaD=8FxJF0BmS7x=8SmgWtRW+m=-Fcw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f1a7d16-79af-aa06-af33-e349a08aa53e@redhat.com>
Date: Fri, 22 Jun 2018 09:46:37 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_DR6xftAT0wjbHaD=8FxJF0BmS7x=8SmgWtRW+m=-Fcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 0/9] bitmap export over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/22/2018 07:13 AM, Peter Maydell wrote:
> On 22 June 2018 at 13:12, Eric Blake <eblake@redhat.com> wrote:
>> Uurgh. It's a false positive (the compiler is complaining that the variable
>> is uninitialized, which can only happen if the while loop is not executed;
>> but the preconditions guarantee the loop executes at least once).  The
>> assert() that I added was enough to silence gcc 7.3.1 on my Fedora 27
>> system, but docker-mingw@fedora is using gcc-8.1.1-1.fc28.x86_64. This
>> should silence things (another way to silence would be rewriting while{}
>> into do{}while).  I'll submit this as a formal patch if I can reproduce the
>> problem/fix on docker.
> 
> Huh. I had thought this was an old-gcc problem, not a new-gcc
> one. Might be worth submitting to the gcc folks as a regression...

Hmm, I couldn't quickly reproduce it with a direct gcc on Fedora 28; and 
I don't know docker well enough to know if the cross-gcc used in 
docker-mingw@fedora is a different version than the native gcc-8.1.1 
listed in the installed packages list (the patchew output doesn't list 
the version of x86_64-w64-mingw32-gcc). Thus, I can't tell if it is a 
recent gcc regression or merely an old-gcc issue.  But I can confirm 
that 'make docker-test-mingw@fedora' reproduced the problem without my 
cleanup patch, and that my cleanup patch now in master made that happy 
again.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
