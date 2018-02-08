Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ejhtu-0001iX-1x
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 03:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ejhtp-0003wr-2n
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 03:49:50 -0500
References: <20180207161730.17194-1-lvivier@redhat.com>
	<20180207212148.73c77de1@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ccacc847-3778-3446-ae87-84413b2c3892@redhat.com>
Date: Thu, 8 Feb 2018 09:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180207212148.73c77de1@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: check smp_threads < vsmt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 07/02/2018 21:21, Greg Kurz wrote:
> On Wed,  7 Feb 2018 17:17:30 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> We ignore silently the value of smp_threads when we set
>> the VSMT value, and if smp_threads is greater than VSMT
>> kernel is going into trouble later.
>>
>> Fixes: 8904e5a750
>> ("spapr: Adjust default VSMT value for better migration compatibility")
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 32a876be56..638b3cafd0 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2294,15 +2294,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
>>      }
>>  
>>      /* Detemine the VSMT mode to use: */
>> -    if (vsmt_user) {
>> -        if (spapr->vsmt < smp_threads) {
>> -            error_setg(&local_err, "Cannot support VSMT mode %d"
>> -                         " because it must be >= threads/core (%d)",
>> -                         spapr->vsmt, smp_threads);
> 
> In this case, we'd error out because the user requested two settings that
> are known to be incompatible.
> 
>> -            goto out;
>> -        }
>> -        /* In this case, spapr->vsmt has been set by the command line */
>> -    } else {
>> +    if (!vsmt_user) {
>>          /*
>>           * Default VSMT value is tricky, because we need it to be as
>>           * consistent as possible (for migration), but this requires
>> @@ -2313,6 +2305,13 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
>>          spapr->vsmt = 8;
> 
> In this case, we'd error out because the user requested a setting that is
> incompatible with our default. Maybe worth a separate error message ?
> 
> "Cannot support %d threads/core because it must be <= to default VSMT mode (8)"

I'm going to update the error message.

Thanks,
Laurent
