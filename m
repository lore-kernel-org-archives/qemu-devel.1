Received: from eggs.gnu.org ([2001:4830:134:3::10]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dTUn4-0001qY-R9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dTUmz-0004Ph-UV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:03:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46474 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dTUmz-0004PD-NB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:03:25 -0400
References: <1499429683-73361-1-git-send-email-agraf@suse.de>
	<20170707150011.GH2451@work-vm>
From: Alexander Graf <agraf@suse.de>
Message-ID: <1b6bf5d1-8477-1697-16e9-091c1b762bd4@suse.de>
Date: Fri, 7 Jul 2017 17:03:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170707150011.GH2451@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: Make analyze-migration script
 target-page-size aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>



On 07.07.17 17:00, Dr. David Alan Gilbert wrote:
> * Alexander Graf (agraf@suse.de) wrote:
>> The configuration section has a new subsection to transmit the target page
>> size along with the migration stream. The analyze migration script needs
>> to learn about that to read configuration streams that were triggering
>> this subsection to get transmitted.
>>
>> With this patch applied, I can successfully analyze migration streams
>> on AArch64 again.
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>>   scripts/analyze-migration.py | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
>> index 1455387..02784f2 100755
>> --- a/scripts/analyze-migration.py
>> +++ b/scripts/analyze-migration.py
>> @@ -254,12 +254,25 @@ class HTABSection(object):
> 
> (Note I'm not a particularly python person, so take lightly)
> 
>>   class ConfigurationSection(object):
>> +    QEMU_VM_SUBSECTION    = 0x05
>> +
> 
> It's odd, you already have this constant defined twice in this script.

Yes, it lives once per class. I am not sure how to easily make it a global.

> 
>>       def __init__(self, file):
>>           self.file = file
>>   
>>       def read(self):
>>           name_len = self.file.read32()
>>           name = self.file.readstr(len = name_len)
>> +        oldpos = self.file.tell()
>> +        if self.file.read8() == self.QEMU_VM_SUBSECTION:
>> +            name = self.file.readstr()
>> +            version_id = self.file.read32()
>> +            if name == "configuration/target-page-bits":
>> +                target_page_size = self.file.read32()
> 
> All of your other references to target_page_size in the script
> are self.TARGET_PAGE_SIZE.

Well, all other ones are actual page sizes :). This variable is never 
used anywhere - we just want to stash it somewhere.

> You might want to make the conditional subsection check into a function
> somewhere, but that's OK for now.

I really hope we don't need it again. All subsections should be 
described via the in-stream json description. We just missed out the 
configuration one because it's not part of the object model.


Alex
