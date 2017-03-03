Received: from eggs.gnu.org ([2001:4830:134:3::10]:46762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cjizC-0002wl-VY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cjiz9-0003J5-SK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:54:51 -0500
Received: from mail-db5eur01on0119.outbound.protection.outlook.com
	([104.47.2.119]:42432
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1cjiz9-0003Hq-8p
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 03:54:47 -0500
References: <20170203152321.19739-1-pbutsykin@virtuozzo.com>
	<20170214140249.GJ2463@work-vm>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <58B92BD6.2030404@virtuozzo.com>
Date: Fri, 3 Mar 2017 11:39:50 +0300
MIME-Version: 1.0
In-Reply-To: <20170214140249.GJ2463@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] migration capability to discard the
 migrated ram pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On 14.02.2017 17:02, Dr. David Alan Gilbert wrote:
> Hi Pavel,
>    I was curious, having merged this, how you're using postcopy; do you switch
> into postcopy mode immediately or wait until the first sync or what?
> Do you find yourself in postcopy mode long enough that it's worth
> doing the release?  If so on what size VMs are you working with?
>
> Dave

Hi Dave,
I'm sorry it took so long, I was on vacation. And thanks for the quick
review and merge!

We want to use this function to update Qemu without rebooting VMs. It
looks like a local migration on the same host. Now, switching into
postcopy mode is done immediately, the size of VMs can be very
different.

> * Pavel Butsykin (pbutsykin@virtuozzo.com) wrote:
>> This feature frees the migrated memory on the source during postcopy-ram
>> migration. In the second step of postcopy-ram migration when the source vm
>> is put on pause we can free unnecessary memory. It will allow, in particular,
>> to start relaxing the memory stress on the source host in a load-balancing
>> scenario.
>>
>> Changes from v1:
>> - changed name of the interfaces (discard to release)
>> - fix make check error
>> - add more comments to qemu_iovec_release_ram()
>> - rebase on "Postcopy: Hugepage support" (David's patch series)
>> - removed ram_discard_page for xbzrle
>> - fix erroneous release memory in complete precopy (tie release-ram to postcopy)
>>
>> Pavel Butsykin (3):
>>    migration: add MigrationState arg for ram_save_/compressed_/page()
>>    add 'release-ram' migrate capability
>>    migration: discard non-dirty ram pages after the start of postcopy
>>
>>   include/migration/migration.h |  2 ++
>>   include/migration/qemu-file.h |  3 ++-
>>   migration/migration.c         | 13 ++++++++++
>>   migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
>>   migration/ram.c               | 56 ++++++++++++++++++++++++++++++++++------
>>   qapi-schema.json              |  5 +++-
>>   6 files changed, 121 insertions(+), 17 deletions(-)
>>
>> --
>> 2.11.0
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
