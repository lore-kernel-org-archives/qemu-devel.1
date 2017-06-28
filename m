Received: from eggs.gnu.org ([2001:4830:134:3::10]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQAeB-00074g-4V
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQAeA-0005AL-BB
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:56:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dQAeA-00059V-5O
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:56:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1498530543.git.maozy.fnst@cn.fujitsu.com>
	<c5ea94f976cb60151fb14a4e25867d73027c5d96.1498530543.git.maozy.fnst@cn.fujitsu.com>
	<87tw31luv3.fsf@dusky.pond.sub.org>
	<fe570119-ce7f-9427-99b7-0b83786ada28@cn.fujitsu.com>
	<87vangd5hh.fsf@dusky.pond.sub.org>
	<f2cded5e-22cf-38f5-69d0-ac3b0e6ba8c2@redhat.com>
Date: Wed, 28 Jun 2017 12:56:28 +0200
In-Reply-To: <f2cded5e-22cf-38f5-69d0-ac3b0e6ba8c2@redhat.com> (Paolo
	Bonzini's message of "Wed, 28 Jun 2017 10:02:37 +0200")
Message-ID: <87efu4pehv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/4] net/net: Convert parse_host_port()
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/06/2017 07:51, Markus Armbruster wrote:
>>> The gethostbyname() return a null pointer if an error occurs, and the h_errno
>>> variable holds an error number. herror() and hstrerror() can prints the error
>>> message associated with the current value of h_errno, but hstrerror() returns
>>> the string type is good for passing the error message to Error. So I'd prefer
>>> the hstrerror.
>>>
>>> As for the portability of hstrerror(), sorry, I'm also not sure, but in this
>>> case I tested, it's OK. so I want to use hstrerror() for a while, if there are
>>> any problem that can be fixed later. Do you think it can be done?
>>
>> Standard first portability question: does Windows provide it?
>
> Nope.  But it does have gai_strerror.

Let's go with the generic error message I suggested, and leave adding
detail to the patch that converts to getaddrinfo().
