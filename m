Received: from eggs.gnu.org ([2001:4830:134:3::10]:55733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey026-0007Qw-Cf
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey023-0003mK-Bo
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:01:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ey023-0003l0-6q
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:01:19 -0400
References: <20180319164152.1077050-1-eblake@redhat.com>
	<CAFEAcA_gF=tpvZLTJ_K5mU59VzByh7XRJSVHFms2i5RJBH7CoA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6686106c-3866-ede4-b1ae-75bf18a948e8@redhat.com>
Date: Mon, 19 Mar 2018 14:01:01 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gF=tpvZLTJ_K5mU59VzByh7XRJSVHFms2i5RJBH7CoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 03/19/2018 01:43 PM, Peter Maydell wrote:
> On 19 March 2018 at 16:41, Eric Blake <eblake@redhat.com> wrote:
>> The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805be:
>>
>>    Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-03-19 11:44:26 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12-v3
>>
>> for you to fetch changes up to ebf1105a7086897da6963edefdb247c80f605424:
>>
>>    qapi: Pass '-u' when doing non-silent diff (2018-03-19 11:32:36 -0500)
>>
>> in v3:
>> rebase to master (a few more qobject_to_qdict() uses crept in)
>> squash in Peter Xu's fixup for test failures
>> [if tests still fail, then I will send a v4 without OOB from 2.12]
>> sending only the patches that changed from v2

> 
> The assert seems to have gone away,

Progress! Peter's OOB patches are working; your ubsan errors are from a 
different part of the series.

> but I get over 10,000 new
> clang sanitizer runtime errors like
> 
>    /visitor/input/large_number:                                         OK
>    /visitor/input/number_keyval:                                        OK
>    /visitor/input/number_str_keyval:                                    OK
>    /visitor/input/number_str_fail:
> /home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:550:12:
> runtime error: member access within null pointer of type 'QNum' (aka
> 'struct QNum')
> OK

> Here's some backtraces for some of those:
> 
> /visitor/input/int_keyval:
> /home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:188:12:
> runtime error: member access within null pointer of type 'QString'
> (aka 'struct QString')
>      #0 0x56375e642549 in qobject_input_get_keyval
> /home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:188:12
>      #1 0x56375e63f76b in qobject_input_type_int64_keyval
> /home/petmay01/linaro/qemu-for-merges/qapi/qobject-input-visitor.c:409:23
>      #2 0x56375e63c13d in visit_type_int
> /home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:150:5

Max, this is the qobject_to() macro that is making ubsan gripe :(

     qstr = qobject_to(QString, qobj);

which partially expands to

     qstr = container_of(qobject_check_type(qobj,
        QTYPE_CAST_TO_QString)) ?: QOBJECT((QString *)NULL), QString, base);

I'm guessing that container_of(NULL, type, base) is what ubsan is 
griping at?  Can we rewrite qobject_to() to only call container_of() if 
qobject_check_type() returns non-NULL?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
