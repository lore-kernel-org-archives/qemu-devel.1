Received: from eggs.gnu.org ([2001:4830:134:3::10]:51568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew7hH-0007We-FE
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew7hC-0005zL-Iz
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:48:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew7hC-0005xd-E7
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:48:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74BE9406E8A4
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 14:48:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180307113834.GL20201@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 7 Mar 2018 11:38:34 +0000")
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-4-quintela@redhat.com>
	<20180307113834.GL20201@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 14 Mar 2018 15:48:45 +0100
Message-ID: <874lliu302.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 03/24] migration: Create tcp_port
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Mar 07, 2018 at 11:59:49AM +0100, Juan Quintela wrote:
>> It will be used to store the uri tcp_port parameter.  This is the only
>> parameter than can change and we can need to be able to connect to it.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>>  # TODO either fuse back into MigrationParameters, or make
>> @@ -584,7 +591,8 @@
>>              '*block-incremental': 'bool',
>>              '*x-multifd-channels': 'int',
>>              '*x-multifd-page-count': 'int',
>> -            '*xbzrle-cache-size': 'size' } }
>> +            '*xbzrle-cache-size': 'size',
>> +            '*x-tcp-port': 'uint16'} }
>
> This should not exist - this exposes this parameter in migate-set-parameters
> as a end user settable property, which is definitely not desirable.
>
> It is only something we should report with 'query-migrate' / 'info migrate'

Oops, my understanding was that the three places have to be in sync.
Now I stand corrected.  Thanks.


>
>>  # @migrate-set-parameters:
>> @@ -667,6 +675,10 @@
>>  #                     needs to be a multiple of the target page size
>>  #                     and a power of 2
>>  #                     (Since 2.11)
>> +#
>> +# @x-tcp-port: Only used for tcp, to know what the real port is
>> +#                     (Since 2.12)
>> +#
>>  # Since: 2.4
>>  ##
>>  { 'struct': 'MigrationParameters',
>> @@ -683,7 +695,8 @@
>>              '*block-incremental': 'bool' ,
>>              '*x-multifd-channels': 'uint8',
>>              '*x-multifd-page-count': 'uint32',
>> -            '*xbzrle-cache-size': 'size' } }
>> +            '*xbzrle-cache-size': 'size',
>> +            '*x-tcp-port': 'uint16'} }
>
> As mentioned in previous review, IMHO we should be reporting the full
> socket address, and allow an array of them, since we're going to have
> more than one address available. i.e.
>
>    '*socket-address': ['SocketAddress']

This is weird, really weird.  But was done.

- this needs to be copied, because it is a pointer, so we end needing
  QAPI_CLONE(), yes, I know.
- it is really weird that I have to:

    rsp_return = qdict_get_qdict(rsp, "return");
    object = qdict_get(rsp_return, parameter);

    iv = qobject_input_visitor_new(object);
    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
    result = g_strdup_printf("%s",
                             SocketAddress_to_str("", saddr, false, false));
    QDECREF(rsp);

  Remember, it is a *series* of strings in the ddict, we have code to
  _print_ qdicts, as info migrate works.  But I haven't found an easier
  way of getting from a qdict to an string than:
    * parsing it
    * convert it back to text
  sniff

> It doesn't cover non-socket based URIs, but that's fine, because for those
> the mgmt app already knows how the channel is setup. We just need the
> array of SocketAddress, because for socket URIs, the hostname, gets turned
> into an array of addresses, and the mgmt app can't discover them.

SocketAddress are a mess, there is not a single example that I can find
on how to use it on the whole tree.  I *think* that I did that right,
will see your comments on the next post.

Later, Juan.
