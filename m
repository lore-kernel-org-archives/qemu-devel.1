Received: from eggs.gnu.org ([2001:4830:134:3::10]:46670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZIee-0003Jy-16
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZIea-0003St-0k
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:55:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZIeZ-0003QK-Pd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:55:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so16637101wrs.8
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 08:55:31 -0800 (PST)
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218092648-mutt-send-email-mst@kernel.org>
	<028f1498-d0bc-e920-1c7c-9a1f0bdded58@redhat.com>
	<20181218095334-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bdc695a3-674e-b0de-690d-160146beefb8@redhat.com>
Date: Tue, 18 Dec 2018 17:55:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181218095334-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>

On 12/18/18 3:54 PM, Michael S. Tsirkin wrote:
> On Tue, Dec 18, 2018 at 03:45:08PM +0100, Paolo Bonzini wrote:
>> On 18/12/18 15:31, Michael S. Tsirkin wrote:
>>> Do you happen to know why does it build fine with
>>> Gcc 8.2.1?
>>>
>>> Reading the GCC manual it seems that
>>> there is a "nostring" attribute that means
>>> "might not be 0 terminated".
>>> I think we should switch to that which fixes the warning
>>> but also warns if someone tries to misuse these
>>> as C-strings.
>>>
>>> Seems to be a better option, does it not?
>>>
>>>
>>
>> Using strpadcpy is clever and self-documenting, though.  We have it
>> already, so why not use it.
>>
>> Paolo
> 
> The advantage of nonstring is that it will catch attempts to
> use these fields with functions that expect a 0 terminated string.
> 
> strpadcpy will instead just silence the warning.

migration/global_state.c:109:15: error: 'strlen' argument 1 declared
attribute 'nonstring' [-Werror=stringop-overflow=]
     s->size = strlen((char *)s->runstate) + 1;
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~

GCC won... It is true this strlen() is buggy, indeed s->runstate might
be not NUL-terminated.
