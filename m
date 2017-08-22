Received: from eggs.gnu.org ([2001:4830:134:3::10]:52967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dk7DY-0000tz-Ra
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dk7DV-00045W-L4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:19:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dk7DV-00045D-Ex
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:19:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7MBJRng112716
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 07:19:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cgkcn98b3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 07:19:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 22 Aug 2017 12:19:23 +0100
References: <20170818222313.13391-1-eblake@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 22 Aug 2017 13:19:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170818222313.13391-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, f4bug@amsat.org



On 08/19/2017 12:23 AM, Eric Blake wrote:
> We already have several files that knowingly require assert()
> to work.  While we do NOT want to encourage the use of
> 'assert(side-effects)' (that is a bad practice that prevents
> copy-and-paste of code to other projects that CAN disable
> assertions; plus it costs unnecessary reviewer mental cycles
> to remember our project policy on crippling asserts), we DO
> want to send a message that anyone that disables assertions
> has to tweak code in order to compile, making it obvious that
> we are not going to support their efforts.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> First mentioned as an idea here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html
> but I'm titling this RFC as I'm not 100% convinced we want to make
> it a project-wide, rather than a per-file decision.


I think project wide is just right for what you describe: tell the people
before disabling assertions you have to change the code (and preferably
at least examine each usage of assert project-wide).

OTOH I do think this is to some degree institutionalizing a bad practice
(you say we do not want to do that, but IMHO refusing to build with
NDEBUG makes only sense if we want to alter the semantic of assert so
that once bad becomes acceptable). I can live with that, but I'm not
happy about it. Have we considered rolling our own construct which is
designed to exhibit the properties we desire?

I mean, if it's about the side effects we could create something like
q_assert(cond) and state that cond is evaluate exactly once (and
depending on what we want to have, make the actions on !cond (calling
abort(), producing a diagnostic message) compile time tweak-able or
not). I assume we could then convert each usage of assert to the safe
q_assert programmatically.

Regards,
Halil
