Received: from eggs.gnu.org ([209.51.188.92]:44354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grMWf-0007iz-Ir
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grMWc-0005jL-O9
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:42:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1grMWa-0005gB-M7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:41:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 942B642BA0
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 12:32:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <711166e7-e8de-9335-5a7f-63cf86a62524@redhat.com> (Eric Blake's
	message of "Wed, 30 Jan 2019 09:55:30 -0600")
References: <20190130120616.5260-1-quintela@redhat.com>
	<20190130120616.5260-3-quintela@redhat.com>
	<711166e7-e8de-9335-5a7f-63cf86a62524@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 06 Feb 2019 13:35:25 +0100
Message-ID: <875ztxf62a.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 2/4] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> On 1/30/19 6:06 AM, Juan Quintela wrote:
>> It will be used to store the uri parameters. We want this only for
>> tcp, so we don't set it for other uris.  We need it to know what port
>> is migration running.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> +        return g_strdup_printf("fd:%s", addr->u.fd.str);
>> +        break;
>> +    default:
>> +        abort();
>
> Is abort()ing on SOCKET_ADDRESS_TYPE_VSOCK intentional?

No.  Althought migration has no clue about how to handle VSOCK.  Changed
it to return something sensible for vsock and an "unknown" message for default.

>
>> +    }
>> +}
>> +
>>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>  {
>>      MigrationInfo *info;
>> @@ -306,6 +326,17 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>          g_free(str);
>>          visit_free(v);
>>      }
>> +    if (info->has_socket_address) {
>> +        SocketAddressList *addr;
>> +
>> +        monitor_printf(mon, "socket address: [\n");
>> +
>> +        for (addr = info->socket_address; addr; addr = addr->next) {
>> +            char *s = SocketAddress_to_str(addr->value);
>> +            monitor_printf(mon, "\t%s\n", s);
>> +        }
>> +        monitor_printf(mon, "]\n");
>> +    }
>
> Leaks 's'.

Good catch.

>> @@ -199,6 +200,8 @@
>>  # @compression: migration compression statistics, only returned if compression
>>  #           feature is on and status is 'active' or 'completed' (Since 3.1)
>>  #
>> +# @socket-address: Only used for tcp, to know what the real port is (Since 3.1)
>> +#
>
> s/3.1/4.0/

Done.

>> +##
>> +# @DummyStruct:
>> +#
>> +# Both block-core and migration needs SocketAddressList
>> +# I am open to comments about how to share it
>> +#
>> +# @dummy-list: A dummy list
>> +#
>> +# Since: 3.1
>
> s/3.1/4.0/
> This matches how we force list types elsewhere for use in C code even
> when the type is not exposed through QMP. But do you still need to force
> the generation, given that ['SocketAddress'] used in MigrationInfo is
> visible through QMP?

I think so but I am not an expert here.

Later, Juan.
