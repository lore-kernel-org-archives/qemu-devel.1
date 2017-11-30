Received: from eggs.gnu.org ([2001:4830:134:3::10]:60285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQFT-0002Mj-OH
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQFS-000340-Ny
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:55:35 -0500
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130134159.9697-4-eblake@redhat.com>
	<20171130163902-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <348c5850-b1b8-2456-9c83-f17160d6b670@redhat.com>
Date: Thu, 30 Nov 2017 08:55:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171130163902-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] maint: Fix macros with broken
 'do/while(0); ' usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On 11/30/2017 08:43 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 30, 2017 at 07:41:59AM -0600, Eric Blake wrote:
>> The point of writing a macro embedded in a 'do { ... } while (0)'
>> loop is so that the macro can be used as a drop-in statement with
>> the caller supplying the trailing ';'.  Although our coding style
>> frowns on brace-less 'if':
>>    if (cond)
>>      statement;
>>    else
>>      something else;
>> the use of do/while (0) in a macro is absolutely essential for the
>> purpose of avoiding a syntax error on the 'else' - but it only works
>> if there is no trailing ';' in the macro (as the ';' in the code
>> calling the macro would then be a second statement and cause the
>> 'else' to not pair to the 'if').
> 
> Shouldn't matter if everyone puts the statements in {}, right?

Correct - where we follow our style, spurious ';' don't make a 
difference (other than they might trigger a warning in a very particular 
compiler).  But it also makes our code harder to copy-and-paste into 
other projects with a different style.

> 
>> Many of the places touched in this code are examples of the ugly
>> bit-rotting debug print statements; cleaning those up is left as
>> a bite-sized task for another day.
>>
>> Found mechanically via: $ git grep -B1 'while (0);' | grep -A1 \\\\
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> We can't really rely on code still building for this to do the right
> thing, can we?

Some of the uses that were changed are in dead #ifdefs for debugging 
purposes - the only way to still compile is to turn on the debugging, 
but that may fail to compile for other reasons (if the format strings 
have bit-rotted, for example).

The only sure way to know that this did not break anything is to audit 
that for every macro where I eliminated the ';', all callers of that 
macro call 'foo();'.  I did not perform that audit (the patch was 
mechanical) - but am willing to do so and reply back with results if you 
need the extra confidence.

>  I did my best to look for uses and I think it's OK, so
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> but I'm not merging this.

What tree should it go through instead? Does it need to be split along 
maintainer boundaries?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
