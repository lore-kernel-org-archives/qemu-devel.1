Received: from eggs.gnu.org ([2001:4830:134:3::10]:34703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esnkx-0006gt-5B
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esnkt-0007Ep-95
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:54:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1esnkt-0007Eb-4M
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:54:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814158424C
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 10:53:56 +0000 (UTC)
References: <1520243276-30197-1-git-send-email-thuth@redhat.com>
	<20180305100928.dg5h77wsoadwl42p@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52bde551-4789-0083-52f3-4565f18b0766@redhat.com>
Date: Mon, 5 Mar 2018 11:53:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180305100928.dg5h77wsoadwl42p@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Allow to specify a display device ID
 and head whith the screendump command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On 05.03.2018 11:09, Gerd Hoffmann wrote:
>> -void qmp_screendump(const char *filename, Error **errp)
>> +void qmp_screendump(const char *filename, bool has_device, const char *device,
>> +                    bool has_head, int64_t head, Error **errp)
>>  {
>>      QemuConsole *con = qemu_console_lookup_by_index(0);
> 
> This initialization can be dropped ...

D'oh, copy-n-paste error ... I'll send a v3 ...

 Thomas


>>      DisplaySurface *surface;
>>  
>> -    if (con == NULL) {
>> -        error_setg(errp, "There is no QemuConsole I can screendump from.");
>> -        return;
>> +    if (has_device) {
>> +        con = qemu_console_lookup_by_device_name(device, has_head ? head : 0,
>> +                                                 errp);
>> +        if (!con) {
>> +            return;
>> +        }
>> +    } else {
>> +        if (has_head) {
>> +            error_setg(errp, "'head' must be specified together with 'device'");
>> +            return;
>> +        }
>> +        con = qemu_console_lookup_by_index(0);
> 
> ... because it is called here now.
> 
> Otherwise looks fine now.
> 
> cheers,
>   Gerd
> 
