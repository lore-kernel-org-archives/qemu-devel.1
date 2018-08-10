Received: from eggs.gnu.org ([2001:4830:134:3::10]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo83V-0002qK-FV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo83P-0001xd-OJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo83P-0001xF-JH
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 10:06:11 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-6-armbru@redhat.com>
	<36518ac8-f022-c54d-2e57-6a709b3678ce@redhat.com>
	<87d0uqmiq9.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1ad880a-7561-f784-b47e-ca3ea6d7b524@redhat.com>
Date: Fri, 10 Aug 2018 09:06:07 -0500
MIME-Version: 1.0
In-Reply-To: <87d0uqmiq9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/56] qmp-test: Cover syntax and lexical
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/10/2018 08:52 AM, Markus Armbruster wrote:

>>> +    /* lexical error: impossible byte outside string */
>>> +    qtest_qmp_send_raw(qts, "{\xFF");
>>
>> \xff is an impossible byte inside a string as well; plus it has
>> special meaning to at least QMP for commanding a parser reset. Is a
>> better byte more appropriate (maybe \x7f), either in replacement to
>> \xff or as an additional test?
> 
> \xFF is documented to have special meaning for QGA, but as far as the
> code's concerned, it's a lexical error like any other.  I'm fixing the
> documentation in PATCH 56.  Want me to move that patch to the front of
> the series?

Might not hurt. We also have a potential design decision to make: for 
most lexical errors, we report the error (with QGA, the user then 
requests that the first valid command after the client's induced lexical 
error also include an 0xff reply byte so that the client can easily skip 
over all the line noise, including said error reports).  Thus, we COULD 
decide to make our parser specifically accept 0xff as a new token, 
different from the lexical error token, so that it inhibits wasted error 
messages to the client on the grounds that the client sent it on 
purpose, differently from all other ways the client can use a lexical 
error to cause a reset.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
