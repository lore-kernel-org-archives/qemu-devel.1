Received: from eggs.gnu.org ([2001:4830:134:3::10]:49055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frp55-0007G7-1Y
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frp4z-000779-5r
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:39:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1frp4v-00072T-36
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:39:01 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-53-armbru@redhat.com>
	<fa470eb3-cc13-1ab3-b0d5-19343bc3b038@redhat.com>
	<87k1olqmri.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <226818c6-e0d6-fc81-c473-98bcb656d3bd@redhat.com>
Date: Mon, 20 Aug 2018 13:38:55 -0500
MIME-Version: 1.0
In-Reply-To: <87k1olqmri.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 52/60] json: Eliminate lexer state
 IN_WHITESPACE, pseudo-token JSON_SKIP
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

On 08/20/2018 06:51 AM, Markus Armbruster wrote:

>> Hmm, if we did this:
>>
>> [IN_START_INTERPOL] {
>>    ['%'] = IN_INTERPOL,
>>    ['\t'] = IN_START_INTERPOL,
>> ...
>> }
>>
>> for similarity with all our other constructs, will gcc remember that
>> we've already initialized other members not listed in the clause
>> before, or will it mistakenly re-0-initialize the array members not
>> mentioned?
> 
> Fails make check.
> 
> (gdb) p json_lexer[IN_START_INTERPOL]
> $1 = "\000\000\000\000\000\000\000\000\000\016\016\000\000\016", '\000' <repeats 18 times>, "\016\000\000\000\000\035", '\000' <repeats 217 times>

And thus answered my question - abbreviating causes gcc to 
re-zero-initialize any unmentioned members, so your override has to be 
one member at a time, as originally written.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
