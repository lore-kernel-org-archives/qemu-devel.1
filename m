Received: from eggs.gnu.org ([208.118.235.92]:51175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evPsP-00054S-Nm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evPsO-00010k-V1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evPsO-0000zQ-QL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:40 -0400
References: <20180312153344.23453-1-nia.alarie@gmail.com>
	<ad11c22e-294b-d7e3-1589-7c4a42351980@redhat.com>
	<CA+k8WDptLRVNBstB4UEoaorS++_Xqn-j+FHYZhHG1igAJWB-rg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e1dbfe9-e26b-66b6-7009-1c2015160c97@redhat.com>
Date: Mon, 12 Mar 2018 11:00:39 -0500
MIME-Version: 1.0
In-Reply-To: <CA+k8WDptLRVNBstB4UEoaorS++_Xqn-j+FHYZhHG1igAJWB-rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9p: Convert use of atoi to qemu_strtoi
 to allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nee <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, groug@kaod.org, Joel Stanley <joel@jms.id.au>

On 03/12/2018 10:50 AM, nee wrote:

>>>        } else if (perm & P9_STAT_MODE_LINK) {
>>> -        int32_t ofid = atoi(extension.data);
>>> -        V9fsFidState *ofidp = get_fid(pdu, ofid);
>>> +        int ofid;
>>
>>
>> 'unsigned int' and...
>>
>>> +        V9fsFidState *ofidp;
>>> +
>>> +        if (qemu_strtoi(extension.data, NULL, 10, &ofid)) {
>>
>>
>> qemu_strtoui() might be smarter, per Greg's comments on v1.
>>
>>> +            err = -EINVAL;
>>> +            goto out;
>>> +        }
>>> +        ofidp = get_fid(pdu, (int32_t)ofid);
>>
>>
>> This cast is spurious.
>>
>> --
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3266
>> Virtualization:  qemu.org | libvirt.org
> 
> I did this because get_fid() takes an int32_t, not an unsigned int.
> The struct V9fsFidState also uses an int32_t for its `fid` member. Do
> you want me to change all these types, or just the function being used
> here?

I'll let Greg answer; he's more familiar with the 9p code (I was just 
commenting based on his initial answer to v1).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
