Received: from eggs.gnu.org ([2001:4830:134:3::10]:52164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnm91-0005UR-W7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnm8w-0003Eu-N0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:05:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnm8w-0003EU-HU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:05:38 -0400
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
	<20170314115253.GL2652@redhat.com>
	<d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
	<20170314123254.GB21475@vader>
	<b27ec1df-6c32-0084-1991-283cb2b8f689@redhat.com>
	<20170314130213.GP2652@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca220108-b75c-c3a1-8288-317095bb3dab@redhat.com>
Date: Tue, 14 Mar 2017 14:05:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170314130213.GP2652@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] seccomp: add elevateprivileges
 argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Andy Lutomirski <luto@amacapital.net>



On 14/03/2017 14:02, Daniel P. Berrange wrote:
>>> Can you give an example of such a list?
>> 
>> Well, anything that makes "-sandbox on" more than security theater...  I
>> would consider it a necessary evil, not a good thing to have such a list.
>> 
>> Due to NO_NEW_PRIVS, I think non-migration fork/exec should be on the
>> list, but hopefully nothing else.
>
> The current semantics of '-sandbox on' are that it is documented to not
> break any valid QEMU features. By blocking fork/exec, we make a semantic
> change to the existing behaviour of '-sandbox on'.

I don't propose to block fork/exec.  I propose not to whitelist setuid,
as is the case now too.  It wouldn't be backwards-incompatible.

> So any application
> which has been using '-sandbox on' historically, is at risk of being
> broken when upgrading to QEMU 2.10. It would force the application to
> generate a different CLI for new QEMU - ie to avoid being broken they
> would have to now  add elevateprivs=allow, spawn=allow. I think we have
> to maintain semantic compat with existing usage, which means that
> '-sandbox on' has to remain security theatre.
> 
> So if we want a default config to be more restrictive, then I think you
> realistically have to turn the default parameter into a tri-state
> instead of bool, ie allow '-sandbox default' as an alternative to
> '-sandbox on' that was slightly stronger by blocking fork/exec.

Or just print a warning that "-sandbox on" is useless.  I guess that
would be okay too if we want to be "stronger" than backwards-compatible.

Paolo
