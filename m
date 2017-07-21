Received: from eggs.gnu.org ([2001:4830:134:3::10]:43462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYb6y-0006jU-TK
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYb6u-00050o-1F
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYb6t-0004zX-RI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:49:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7A3C4A6EB
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 16:49:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-6-git-send-email-armbru@redhat.com>
	<d0c08f67-c180-ea20-852d-011376d2b5c5@redhat.com>
Date: Fri, 21 Jul 2017 18:49:01 +0200
In-Reply-To: <d0c08f67-c180-ea20-852d-011376d2b5c5@redhat.com> (Eric Blake's
	message of "Fri, 21 Jul 2017 09:50:33 -0500")
Message-ID: <87poctag76.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/9] tests/libqos/usb: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/21/2017 08:53 AM, Markus Armbruster wrote:
>> Leaving interpolation into JSON to qmp() is more robust than building
>> QMP input manually, as explained in the previous commit.
>> 
>> The case in usb_test_hotplug() slightly more complicated: it
>
> s/()/() is/

Will fix.

>> interpolates *into* JSON values.  Clean it up by building the values
>> separately, so we can again leave interpolation to qmp().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/libqos/usb.c | 30 ++++++++++++++----------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>> 
>> diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
>> index 0cdfaec..f88d4a6 100644
>> --- a/tests/libqos/usb.c
>> +++ b/tests/libqos/usb.c
>> @@ -40,18 +40,20 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
>>  void usb_test_hotplug(const char *hcd_id, const int port,
>>                        void (*port_check)(void))
>>  {
>> +    char id[32];
>> +    char *bus;
>>      QDict *response;
>> -    char  *cmd;
>>  
>> -    cmd = g_strdup_printf("{'execute': 'device_add',"
>> -                          " 'arguments': {"
>> -                          "   'driver': 'usb-tablet',"
>> -                          "   'port': '%d',"
>> -                          "   'bus': '%s.0',"
>> -                          "   'id': 'usbdev%d'"
>> -                          "}}", port, hcd_id, port);
>> -    response = qmp(cmd);
>> -    g_free(cmd);
>> +    sprintf(id, "usbdev%d", port);
>
> I know this fits, but do any of our compilers issue dumb warnings about
> possible buffer overflow?  I guess we'll deal with that if someone
> reports a problem.

We do similar things elsewhere, just grep for sprintf.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
