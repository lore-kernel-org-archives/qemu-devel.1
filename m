Received: from eggs.gnu.org ([2001:4830:134:3::10]:57585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZIRi-0007Ix-Vd
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1eZIRf-0005H7-OO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:37:42 -0500
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-3-git-send-email-den@openvz.org>
	<20171222123802.GB2347@rkaganb.sw.ru>
From: klim <klim.kireev@virtuozzo.com>
Message-ID: <0366d899-d0dd-a8de-11ef-944627867596@virtuozzo.com>
Date: Wed, 10 Jan 2018 18:37:33 +0300
MIME-Version: 1.0
In-Reply-To: <20171222123802.GB2347@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/5] configure: add dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/22/2017 03:38 PM, Roman Kagan wrote:
> On Mon, Dec 18, 2017 at 02:09:08PM +0300, Denis V. Lunev wrote:
>> From: Klim Kireev <klim.kireev@virtuozzo.com>
>>
>> This dependency is required for adequate Parallels images support.
>> Typically the disk consists of several images which are glued by
>> XML disk descriptor. Also XML hides inside several important parameters
>> which are not available in the image header.
>>
>> The patch also adds clause to checkpatch.pl to understand libxml2 types.
> Can't you get by with glib's GMarkup, to avoid extra dependencies?
>
> https://developer.gnome.org/glib/stable/glib-Simple-XML-Subset-Parser.html
>
> Roman.
>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   configure             | 27 +++++++++++++++++++++++++++
>>   block/Makefile.objs   |  2 ++
>>   scripts/checkpatch.pl |  1 +
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 0c6e757..e988fd0 100755
>> --- a/configure
>> +++ b/configure
>> @@ -422,6 +422,7 @@ tcmalloc="no"
>>   jemalloc="no"
>>   replication="yes"
>>   vxhs=""
>> +libxml2=""
>>   
>>   supported_cpu="no"
>>   supported_os="no"
>> @@ -1275,6 +1276,10 @@ for opt do
>>     ;;
>>     --enable-numa) numa="yes"
>>     ;;
>> +  --disable-libxml2) libxml2="no"
>> +  ;;
>> +  --enable-libxml2) libxml2="yes"
>> +  ;;
>>     --disable-tcmalloc) tcmalloc="no"
>>     ;;
>>     --enable-tcmalloc) tcmalloc="yes"
>> @@ -1548,6 +1553,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>>     tpm             TPM support
>>     libssh2         ssh block device support
>>     numa            libnuma support
>> +  libxml2         for Parallels image format
>>     tcmalloc        tcmalloc support
>>     jemalloc        jemalloc support
>>     replication     replication support
>> @@ -1592,6 +1598,20 @@ if test "$ARCH" = "unknown"; then
>>       fi
>>   fi
>>   
>> +# check for libxml2
>> +if test "$libxml2" != "no" ; then
>> +    if $pkg_config --exists libxml-2.0; then
>> +        libxml2="yes"
>> +        libxml2_cflags=$($pkg_config --cflags libxml-2.0)
>> +        libxml2_libs=$($pkg_config --libs libxml-2.0)
>> +    else
>> +        if test "$libxml2" = "yes"; then
>> +            feature_not_found "libxml2" "Install libxml2 devel"
>> +        fi
>> +        libxml2="no"
>> +    fi
>> +fi
>> +
>>   # Consult white-list to determine whether to enable werror
>>   # by default.  Only enable by default for git builds
>>   if test -z "$werror" ; then
>> @@ -5549,6 +5569,7 @@ echo "lzo support       $lzo"
>>   echo "snappy support    $snappy"
>>   echo "bzip2 support     $bzip2"
>>   echo "NUMA host support $numa"
>> +echo "libxml2           $libxml2"
>>   echo "tcmalloc support  $tcmalloc"
>>   echo "jemalloc support  $jemalloc"
>>   echo "avx2 optimization $avx2_opt"
>> @@ -6208,6 +6229,12 @@ if test "$have_rtnetlink" = "yes" ; then
>>     echo "CONFIG_RTNETLINK=y" >> $config_host_mak
>>   fi
>>   
>> +if test "$libxml2" = "yes" ; then
>> +  echo "CONFIG_LIBXML2=y" >> $config_host_mak
>> +  echo "LIBXML2_CFLAGS=$libxml2_cflags" >> $config_host_mak
>> +  echo "LIBXML2_LIBS=$libxml2_libs" >> $config_host_mak
>> +fi
>> +
>>   if test "$replication" = "yes" ; then
>>     echo "CONFIG_REPLICATION=y" >> $config_host_mak
>>   fi
>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>> index 6eaf78a..a73387f 100644
>> --- a/block/Makefile.objs
>> +++ b/block/Makefile.objs
>> @@ -47,3 +47,5 @@ block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
>>   dmg-bz2.o-libs     := $(BZIP2_LIBS)
>>   qcow.o-libs        := -lz
>>   linux-aio.o-libs   := -laio
>> +parallels.o-cflags := $(LIBXML2_CFLAGS)
>> +parallels.o-libs   := $(LIBXML2_LIBS)
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 34df753..e76cc85 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -265,6 +265,7 @@ our @typeList = (
>>   	qr{${Ident}_handler_fn},
>>   	qr{target_(?:u)?long},
>>   	qr{hwaddr},
>> +	qr{xml${Ident}},
>>   );
>>   
>>   # This can be modified by sub possible.  Since it can be empty, be careful
>> -- 
>> 2.7.4
>>
>>
It is inconvenient, because GMarkup sees XML files as series of event, 
while for our purposes the tree model is much more preferable.

Also libvirt depends on libxml2, so it is installed in most cases.
