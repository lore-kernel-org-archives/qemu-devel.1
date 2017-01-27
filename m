Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX6Er-0000gR-SC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX6Em-0000Bh-TX
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:06:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cX6Em-0000BT-MO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:06:44 -0500
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
	<87mvec3bqp.fsf@emacs.mitica>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad61f8a7-e18a-3a20-92d9-8cf11d4a873e@redhat.com>
Date: Fri, 27 Jan 2017 14:06:40 +0100
MIME-Version: 1.0
In-Reply-To: <87mvec3bqp.fsf@emacs.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] mem-prealloc: Reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, Jitendra Kolhe <jitendra.kolhe@hpe.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, armbru@redhat.com, renganathan.meenakshisundaram@hpe.com, mohan_parthasarathy@hpe.com



On 27/01/2017 13:53, Juan Quintela wrote:
>> +static void *do_touch_pages(void *arg)
>> +{
>> +    PageRange *range = (PageRange *)arg;
>> +    char *start_addr = range->addr;
>> +    uint64_t numpages = range->numpages;
>> +    uint64_t hpagesize = range->hpagesize;
>> +    uint64_t i = 0;
>> +
>> +    for (i = 0; i < numpages; i++) {
>> +        memset(start_addr + (hpagesize * i), 0, 1);
> 
> I would use the range->addr and similar here directly, but it is just a
> question of taste.
> 
>> -        /* MAP_POPULATE silently ignores failures */
>> -        for (i = 0; i < numpages; i++) {
>> -            memset(area + (hpagesize * i), 0, 1);
>> +        /* touch pages simultaneously for memory >= 64G */
>> +        if (memory < (1ULL << 36)) {
> 
> 64GB guest already took quite a bit of time, I think I would put it
> always as min(num_vcpus, 16).  So, we always execute the multiple theard
> codepath?

I too would like some kind of heuristic to choose the number of threads.
 Juan's suggested usage of the VCPUs (smp_cpus) is a good one.

Paolo
