Received: from eggs.gnu.org ([2001:4830:134:3::10]:57567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQK2-0007Ol-0U
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQJz-0003vH-9m
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:17:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezQJz-0003v7-4w
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:17:43 -0400
References: <20180323140821.28957-1-peterx@redhat.com>
	<17b3708c-3787-c08d-e960-c6df21114689@redhat.com>
	<ff6a3e78-56dd-aa7b-da36-4d0a79634079@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <758e314f-10d3-d335-9f20-7ee7cf714320@redhat.com>
Date: Fri, 23 Mar 2018 12:17:23 -0500
MIME-Version: 1.0
In-Reply-To: <ff6a3e78-56dd-aa7b-da36-4d0a79634079@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>

On 03/23/2018 10:53 AM, Eric Blake wrote:

> Actually, we should revert things in reverse order of the original 
> commits, so that we aren't introducing yet more temporary breakage.
> 
> Since you reverted:
> 
> $ git describe 3fd2457 d003f7a 91ad450 0213031 --match=v\*
> v2.11.0-2595-g3fd2457d18e
> v2.11.0-2598-gd003f7a8f9c
> v2.11.0-2597-g91ad45061af
> v2.11.0-2585-g02130314d8c
> 
> where the higher the middle number represents the further distance from 
> 2.11 (aka newer patch), this series should be applied in the order:
> 
> 2/4 (revert the newest patch first)
> 3/4
> 1/4
> 4/4

Even that didn't work - 'make check' fails with either 1/4 or 4/4 
applied in isolation, so I'm squashing them into a single patch.

The failure was either:

   GTESTER check-qtest-x86_64
**
ERROR:tests/qmp-test.c:96:test_qmp_protocol: assertion failed: (entry)
GTester: last random seed: R02Sa02aeb0d46d3092524914cd9be2b57f7
make: *** [/home/eblake/qemu/tests/Makefile.include:880: 
check-qtest-x86_64] Error 1


or:

   GTESTER check-qtest-x86_64
**
ERROR:tests/qmp-test.c:92:test_qmp_protocol: assertion failed: 
(capabilities && qlist_empty(capabilities))
GTester: last random seed: R02S621a9dbfcf7bed132c614953e93ecb37
make: *** [/home/eblake/qemu/tests/Makefile.include:880: 
check-qtest-x86_64] Error 1


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
