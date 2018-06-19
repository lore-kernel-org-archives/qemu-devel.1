Received: from eggs.gnu.org ([2001:4830:134:3::10]:54642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVGsI-00025P-6s
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVGsF-0003oK-3b
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVGsE-0003nC-RA
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:40:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615014249.22730-1-peterx@redhat.com>
	<20180615014249.22730-3-peterx@redhat.com>
	<87zhzwbhah.fsf@dusky.pond.sub.org> <20180619043551.GF16790@xz-mi>
Date: Tue, 19 Jun 2018 15:40:23 +0200
In-Reply-To: <20180619043551.GF16790@xz-mi> (Peter Xu's message of "Tue, 19
	Jun 2018 12:35:51 +0800")
Message-ID: <87in6evqrc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/6] monitor: flush qmp responses when
 CLOSED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jun 15, 2018 at 10:11:34AM +0200, Markus Armbruster wrote:
[...]
>> diff --git a/monitor.c b/monitor.c
>> index e59d4f09ac..af28977549 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -512,7 +512,7 @@ struct QMPResponse {
>>  };
>>  typedef struct QMPResponse QMPResponse;
>>  
>> -static QObject *monitor_qmp_response_pop_one(Monitor *mon)
>> +static QObject *monitor_qmp_requests_pop(Monitor *mon)
>
> I guess it's a typo; I'll keep the "response" word.

You're right.

>>  {
>>      QObject *data;
>>  
>> @@ -527,41 +527,39 @@ static void monitor_qmp_response_flush(Monitor *mon)
>>  {
>>      QObject *data;
>>  
>> -    while ((data = monitor_qmp_response_pop_one(mon))) {
>> +    while ((data = monitor_qmp_requests_pop(mon))) {
>
> Same here.
>
>>          monitor_json_emitter_raw(mon, data);
>>          qobject_unref(data);
>>      }
>>  }
>>  
>>  /*
>> - * Return one QMPResponse.  The response is only valid if
>> - * response.data is not NULL.
>> + * Pop a QMPResponse from any monitor's response queue into @response.
>> + * Return NULL when all queues are empty, else @response.
>
> I'll change the return value to a boolean directly if it's okay, since
> after all we'll pass the QMPResponse in now.

I routinely return the buffer argument in cases like this.  It's quite
traditional, e.g. fgets(), memcpy(), strcpy() do it, too.  Occasionally
permits more concise code, but not here.

[...]
