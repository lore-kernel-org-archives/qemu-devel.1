Received: from eggs.gnu.org ([2001:4830:134:3::10]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyvRB-0000gi-Va
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyvR8-0002pF-Tc
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyvR8-0002ob-Mw
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 03:46:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-19-david@redhat.com>
Date: Mon, 02 Oct 2017 09:46:41 +0200
In-Reply-To: <20170913132417.24384-19-david@redhat.com> (David Hildenbrand's
	message of "Wed, 13 Sep 2017 15:24:13 +0200")
Message-ID: <87k20eq9em.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 18/22] s390x: implement
 query-hotpluggable-cpus
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> CPU hotplug is only possible on a per core basis on s390x. So let's
> add possible_cpus and properly wire everything up.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
[...]
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f3af2cb851..79e9f85404 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3121,6 +3121,22 @@
>  #      }
>  #    ]}
>  #
> +# For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu qemu
> +# (Since: 2.11):
> +#
> +# -> { "execute": "query-hotpluggable-cpus" }
> +# <- {"return": [
> +#      {
> +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
> +#         "props": { "core-id": 1 }
> +#      },
> +#      {
> +#         "qom-path": "/machine/unattached/device[0]",
> +#         "type": "qemu-s390-cpu", "vcpus-count": 1,
> +#         "props": { "core-id": 0 }
> +#      }
> +#    ]}
> +#
>  ##
>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }

Please stick in '# Example:' like we do in query-hotpluggable-cpus's doc
comment.  I expect the generated documentation to be illegible[*]
without it.


[*] If you want to perform a quick eye-over, try running "make
tests/qapi-schema/doc-good.test.txt" and examine the result.
