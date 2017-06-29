Received: from eggs.gnu.org ([2001:4830:134:3::10]:58767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQPhv-00085f-B3
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQPhr-00060n-B0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:01:27 -0400
Received: from [59.151.112.132] (port=21828 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dQPhq-0005ut-Vg
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 23:01:23 -0400
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d7c1b8ff9247a09e54110abe6abe93543d59b8b6.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628132329.GJ29134@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <feaa0851-6b5b-8980-7981-c5db74e2f94b@cn.fujitsu.com>
Date: Thu, 29 Jun 2017 11:01:04 +0800
MIME-Version: 1.0
In-Reply-To: <20170628132329.GJ29134@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 3/4] net/net: Convert parse_host_port()
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, armbru@redhat.com

Hi, Daniel

On 06/28/2017 09:23 PM, Daniel P. Berrange wrote:
> On Wed, Jun 28, 2017 at 09:08:49PM +0800, Mao Zhongyi wrote:
>> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>> index 5c326db..78e2b30 100644
>> --- a/include/qemu/sockets.h
>> +++ b/include/qemu/sockets.h
>
>>          if (qemu_isdigit(buf[0])) {
>> -            if (!inet_aton(buf, &saddr->sin_addr))
>> +            if (!inet_aton(buf, &saddr->sin_addr)) {
>> +                error_setg(errp, "host address '%s' is not a valid "
>> +                           "IPv4 address", buf);
>>                  return -1;
>> +            }
>>          } else {
>> -            if ((he = gethostbyname(buf)) == NULL)
>> +            he = gethostbyname(buf);
>> +            if (he == NULL) {
>> +                error_setg(errp, "can't resolve host address '%s': "
>> +                           "unknown host", buf);
>>                  return - 1;
>> +            }
>
> gethostbyname sets  'h_errno' on failure, so you should pass that
> into error_setg_errno, instead of hardcoding 'unknown host' as a
> message

Yes, 'h_errno' will be seted detailed error message when gethostbyname() failed,
but the value of 'h_errno', as far as I know, can be print by hstrerror(),
herror() and gai_strerror(). I'm not sure 'h_errno' can be parsed correctly
by error_setg_errno(), so I test it like this:

herror("----herror----");
error_report("----hstrerror----%s", hstrerror(h_errno));
error_report("----gai_strerror----%s", gai_strerror(h_errno));
error_setg_errno(errp, h_errno, "can't resolve host address '%s'" ,buf);


result:

----herror----: Unknown host
qemu-system-x86_64: -net socket,listen=hostname:: ----hstrerror----Unknown host
qemu-system-x86_64: -net socket,listen=hostname:: ----gai_strerror----Unknown error
qemu-system-x86_64: -net socket,listen=hostname:: can't resolve host address 'hostname': Operation not permitted


 From the results, obviously the error message is different.
error_setg_errno() prints a uncertain message like "Operation not
permitted", I think that the value of 'h_errno' is treated as a
standard error code for errno. Although they have the same value,
the information contained may not be same.

so is it really appropriate to pass 'h_errno' to error_setg_errno()?

Thanks,
Mao


> Regards,
> Daniel
>
