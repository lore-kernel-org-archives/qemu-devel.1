Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBeO-00013r-7T
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBeE-0001mY-Lv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:04:12 -0400
From: Thomas Huth <thuth@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-15-eblake@redhat.com>
	<8064a471-f2ff-63e4-c90d-ebf3ca4e33cd@redhat.com>
Message-ID: <a91fb46c-0044-3fcc-70a7-60f186a37c9f@redhat.com>
Date: Tue, 5 Sep 2017 13:03:38 +0200
MIME-Version: 1.0
In-Reply-To: <8064a471-f2ff-63e4-c90d-ebf3ca4e33cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState
 for fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 05.09.2017 12:12, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> Drop one more client of global_qtest by teaching all fw_cfg test
>> functionality (invoked through alloc-pc) to pass in an explicit
>> QTestState, adjusting all callers.  In particular, fw_cfg-test
>> had to reorder things to create the test state prior to creating
>> the fw_cfg.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/libqos/fw_cfg.h       | 10 ++++++----
>>  tests/libqos/libqos.h       |  2 +-
>>  tests/libqos/malloc-pc.h    |  4 ++--
>>  tests/libqos/malloc-spapr.h |  2 +-
>>  tests/libqos/malloc.h       |  1 +
>>  tests/boot-order-test.c     |  6 +++---
>>  tests/e1000e-test.c         |  2 +-
>>  tests/fw_cfg-test.c         | 14 ++++++--------
>>  tests/ide-test.c            |  2 +-
>>  tests/libqos/fw_cfg.c       | 14 ++++++++------
>>  tests/libqos/libqos.c       |  2 +-
>>  tests/libqos/malloc-pc.c    |  8 ++++----
>>  tests/libqos/malloc-spapr.c |  4 ++--
>>  tests/vhost-user-test.c     |  2 +-
>>  14 files changed, 38 insertions(+), 35 deletions(-)
>>
>> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
>> index e8371b2317..396dd4ee1e 100644
>> --- a/tests/libqos/fw_cfg.h
>> +++ b/tests/libqos/fw_cfg.h
>> @@ -15,10 +15,12 @@
>>
>>
>>  typedef struct QFWCFG QFWCFG;
>> +typedef struct QTestState QTestState;
> 
> Not sure, but I slightly remember that typedeffing a struct like this in
> multiple places can cause compiler warnings or errors with certain
> versions of GCC or clang? So a file that includes both, fw_cfg.h and
> libqtest.h will then fail to compile?
> 
> I think it would be better to change the include order in the .c files
> instead, so that libqtest.h is always included before fw_cfg.h.

Ah, well, I just saw that you also sent a fixup patch for this. Anyway,
I'm not a fan of including header files from other header files, so
changing the include order in the .c files sounds like the better
solution to me.

 Thomas
